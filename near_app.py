from __future__ import annotations

import json
import threading
from http.server import BaseHTTPRequestHandler, HTTPServer
from urllib.parse import urlparse
from uuid import uuid4

from near_core import Message, NearbyUser, NowPost, rank_nearby, safe_recent_label, utc_now

HOST = "127.0.0.1"
PORT = 8787

USERS = rank_nearby([
    NearbyUser("u1", "Aki", 24, ("Cafe", "Music"), 42, "LIVE", verified=True),
    NearbyUser("u2", "Rin", 26, ("Travel", "Food"), 95, "JUST NOW"),
    NearbyUser("u3", "Sora", 23, ("Gaming", "Anime"), 180, "LIVE", verified=True),
    NearbyUser("u4", "Mio", 25, ("Fashion", "Movies"), 310, "RECENT", recent_label=safe_recent_label(5)),
    NearbyUser("u5", "Ren", 28, ("Sports", "Cafe"), 520, "RECENT", recent_label=safe_recent_label(12)),
])

NOW_POSTS = [
    NowPost("n1", "u1", "Aki", "心斎橋周辺", "この辺でカフェ探してる ☕", utc_now().isoformat(), utc_now().isoformat()),
    NowPost("n2", "u3", "Sora", "難波周辺", "今からちょっとゲームする", utc_now().isoformat(), utc_now().isoformat()),
]
MESSAGES: list[Message] = [
    Message("m1", "Aki", "近くにおるやん", utc_now().isoformat()),
]

HTML = r'''<!doctype html>
<html lang="ja"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width,initial-scale=1,viewport-fit=cover"><title>NEAR</title>
<style>
:root{--bg:#07080c;--panel:#11131a;--soft:#1a1d27;--text:#f7f8fb;--muted:#8f95a5;--accent:#7c8cff;--mint:#67f7c4;--line:#252938}
*{box-sizing:border-box}body{margin:0;background:radial-gradient(circle at 50% -10%,#1e2548 0,#07080c 42%);color:var(--text);font-family:Inter,ui-sans-serif,system-ui,-apple-system,BlinkMacSystemFont,"Segoe UI",sans-serif;min-height:100vh;overflow-x:hidden}
button{font:inherit;border:0;color:inherit}.shell{max-width:560px;margin:0 auto;min-height:100vh;padding:18px 14px 92px;position:relative}.top{display:flex;justify-content:space-between;align-items:center;padding:8px 4px 18px}.brand{font-weight:900;font-size:24px;letter-spacing:-.03em}.pill{border:1px solid var(--line);background:#ffffff08;padding:7px 11px;border-radius:999px;color:var(--muted);font-size:12px}
.hero{padding:4px 2px 18px}.eyebrow{font-size:12px;color:var(--mint);font-weight:800;letter-spacing:.08em;text-transform:uppercase}.hero h1{font-size:36px;line-height:1.04;margin:7px 0}.hero p{margin:0;color:var(--muted)}
.section{margin-top:18px}.section-head{display:flex;align-items:center;justify-content:space-between;margin-bottom:10px}.section-title{font-size:14px;font-weight:850}.sub{font-size:12px;color:var(--muted)}
.card{position:relative;background:linear-gradient(150deg,#151824,#0e1016);border:1px solid var(--line);border-radius:24px;padding:16px;margin:10px 0;overflow:hidden;transform:translate3d(0,0,0);transition:transform .16s ease,box-shadow .16s ease,border-color .16s ease}.card.nearest{border-color:#626cff66;box-shadow:0 0 0 1px #626cff22,0 18px 44px #0007}.card:active{transform:scale(.985)}
.avatar{width:48px;height:48px;border-radius:17px;display:grid;place-items:center;font-size:20px;font-weight:900;background:linear-gradient(135deg,#232b51,#141722)}.row{display:flex;gap:12px;align-items:center}.meta{flex:1}.name{font-weight:850}.tags{display:flex;gap:6px;flex-wrap:wrap;margin-top:6px}.tag{font-size:11px;padding:5px 8px;border-radius:999px;background:#ffffff08;color:#b8bdca;border:1px solid #ffffff08}.status{font-size:11px;color:var(--mint);font-weight:800}.distance{font-size:11px;color:#aab0c0}.actions{display:flex;gap:8px;margin-top:14px}.cta{flex:1;background:#f4f6ff;color:#0c0d13;border-radius:14px;padding:12px 14px;font-weight:900;cursor:pointer}.ghost{background:#ffffff08;color:var(--text);border:1px solid var(--line)}
.now{background:linear-gradient(150deg,#151b29,#11131a)}.now strong{display:block;font-size:15px}.now p{color:#b4bac8;margin:7px 0 0;line-height:1.45}.time{font-size:11px;color:var(--muted);margin-top:9px}
.nav{position:fixed;left:50%;bottom:12px;transform:translateX(-50%);width:min(520px,calc(100% - 24px));background:#0e1016ee;border:1px solid #292d3a;backdrop-filter:blur(14px);display:grid;grid-template-columns:repeat(4,1fr);padding:8px;border-radius:22px;box-shadow:0 18px 42px #0009;z-index:10}.nav button{background:transparent;color:var(--muted);padding:10px 0;border-radius:14px;font-size:12px;cursor:pointer}.nav button.active{background:#ffffff0b;color:#fff;font-weight:850}
.chat{display:none}.chat.open{display:block;position:fixed;inset:0;background:#07080c;z-index:20}.chat-inner{max-width:560px;margin:0 auto;height:100%;display:flex;flex-direction:column;padding:14px}.chat-head{display:flex;align-items:center;gap:12px;padding:8px 0 14px;border-bottom:1px solid var(--line)}.back{background:#ffffff08;border:1px solid var(--line);padding:8px 11px;border-radius:12px;cursor:pointer}.messages{flex:1;overflow:auto;padding:18px 2px}.bubble{max-width:80%;padding:11px 13px;border-radius:18px;background:#141824;border:1px solid var(--line);margin:8px 0}.bubble.me{margin-left:auto;background:#ecefff;color:#0a0b10;border:0}.composer{display:flex;gap:8px;padding-top:10px}.composer input{flex:1;background:#10131b;border:1px solid var(--line);color:#fff;border-radius:15px;padding:13px}.send{background:var(--accent);border-radius:15px;padding:0 16px;font-weight:900;cursor:pointer}
.touch{position:fixed;pointer-events:none;width:90px;height:90px;border-radius:50%;transform:translate(-50%,-50%);background:radial-gradient(circle,#91a0ff44 0,#91a0ff12 38%,transparent 68%);mix-blend-mode:screen;opacity:0;transition:opacity .18s;z-index:50}.touch.on{opacity:1}.spark{position:fixed;pointer-events:none;width:6px;height:6px;border-radius:50%;background:#fff;box-shadow:0 0 18px #9ba6ff;z-index:51;animation:spark .45s ease-out forwards}@keyframes spark{to{transform:translate(var(--dx),var(--dy)) scale(0);opacity:0}}
</style></head><body><main class="shell">
<div class="top"><div class="brand">NEAR</div><div class="pill">10分圏 • Live</div></div>
<section class="hero"><div class="eyebrow">YOUR WORLD, RIGHT NOW</div><h1>近くにいる。<br>今つながる。</h1><p>自分の10分圏を、リアルタイムのSocial Worldに。</p></section>
<section id="nearSection"><div class="section-head"><div class="section-title">いちばん近い</div><div class="sub">Closest First</div></div><div id="nearest"></div>
<div class="section-head" style="margin-top:18px"><div class="section-title">近くでアクティブ</div><div class="sub">10分圏</div></div><div id="nearby"></div>
<div class="section-head" style="margin-top:18px"><div class="section-title">RECENT HERE</div><div class="sub">少し前までここにいた</div></div><div id="recent"></div></section>
<section id="nowSection" class="section"><div class="section-head"><div class="section-title">NOW</div><div class="sub">24h</div></div><div id="now"></div></section>
</main>
<div class="nav"><button class="active" data-tab="near">NEAR</button><button data-tab="chat">CHAT</button><button data-tab="now">NOW</button><button data-tab="me">ME</button></div>
<div id="touch" class="touch"></div>
<div id="chat" class="chat"><div class="chat-inner"><div class="chat-head"><button class="back" onclick="closeChat()">戻る</button><div><div class="name" id="chatName">Aki</div><div class="status">● JUST NOW</div></div></div><div class="messages" id="messages"></div><div class="composer"><input id="msg" placeholder="メッセージ…"><button class="send" onclick="sendMessage()">送信</button></div></div></div>
<script>
const users={{users}}; const nowPosts={{now}};
const $=s=>document.querySelector(s); const esc=s=>String(s).replace(/[&<>"']/g,c=>({'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#39;'}[c]));
function card(u,nearest=false){return `<article class="card ${nearest?'nearest':''}" data-id="${esc(u.user_id)}"><div class="row"><div class="avatar">${esc(u.name.slice(0,1))}</div><div class="meta"><div class="name">${esc(u.name)} ${u.verified?'✓':''}</div><div class="tags">${u.interests.map(x=>`<span class="tag">${esc(x)}</span>`).join('')}</div></div><div><div class="status">${esc(u.activity)}</div><div class="distance">${u.distance_m}m</div></div></div>${u.recent_label?`<div class="sub" style="margin-top:12px">${esc(u.recent_label)}</div>`:''}<div class="actions"><button class="cta" onclick="openChat('${esc(u.name)}')">話してみる</button><button class="cta ghost" onclick="pulse(this)">見る</button></div></article>`}
function render(){
 $('#nearest').innerHTML=card(users[0],true); $('#nearby').innerHTML=users.slice(1,4).map(u=>card(u)).join(''); $('#recent').innerHTML=users.filter(u=>u.recent_label).map(u=>card(u)).join('');
 $('#now').innerHTML=nowPosts.map(n=>`<article class="card now"><div class="row"><div class="avatar">${esc(n.name.slice(0,1))}</div><div class="meta"><div class="name">${esc(n.name)}</div><div class="sub">${esc(n.area_label)}</div></div></div><p>${esc(n.text)}</p><div class="time">今この街で見る • 24h</div><div class="actions"><button class="cta" onclick="openChat('${esc(n.name)}')">Chatする</button></div></article>`).join('');
}
function openChat(name){$('#chatName').textContent=name;$('#chat').classList.add('open');$('#messages').innerHTML=`<div class="bubble">こんにちは！${esc(name)}さんに話しかけています。</div><div class="bubble me">近くにいるから話してみた。</div>`}
function closeChat(){$('#chat').classList.remove('open')}
function sendMessage(){const i=$('#msg');if(!i.value.trim())return;const d=document.createElement('div');d.className='bubble me';d.textContent=i.value.trim();$('#messages').appendChild(d);i.value='';$('#messages').scrollTop=99999}
function pulse(el){el.closest('.card').animate([{transform:'scale(.985)'},{transform:'scale(1.01)'},{transform:'scale(1)'}],{duration:280,easing:'cubic-bezier(.2,.8,.2,1)'})}
document.addEventListener('pointermove',e=>{const t=$('#touch');t.style.left=e.clientX+'px';t.style.top=e.clientY+'px';t.classList.add('on')});
document.addEventListener('pointerleave',()=>$('#touch').classList.remove('on'));
document.addEventListener('pointerdown',e=>{for(let i=0;i<3;i++){const s=document.createElement('span');s.className='spark';s.style.left=e.clientX+'px';s.style.top=e.clientY+'px';s.style.setProperty('--dx',`${(Math.random()-.5)*44}px`);s.style.setProperty('--dy',`${(Math.random()-.5)*44}px`);document.body.appendChild(s);setTimeout(()=>s.remove(),500)}});
document.querySelectorAll('.nav button').forEach(b=>b.addEventListener('click',()=>{document.querySelectorAll('.nav button').forEach(x=>x.classList.remove('active'));b.classList.add('active');const tab=b.dataset.tab;if(tab==='chat'){openChat('NEAR');}else if(tab==='now'){$('#nowSection').scrollIntoView({behavior:'smooth'});}else if(tab==='me'){alert('ME / Profile は次Waveで実装');}else{window.scrollTo({top:0,behavior:'smooth'})}}));
render();
</script></body></html>'''

class Handler(BaseHTTPRequestHandler):
    def _send(self, status: int, body: str, content_type: str = "text/html; charset=utf-8") -> None:
        raw = body.encode("utf-8")
        self.send_response(status)
        self.send_header("Content-Type", content_type)
        self.send_header("Content-Length", str(len(raw)))
        self.end_headers(); self.wfile.write(raw)

    def do_GET(self):
        path = urlparse(self.path).path
        if path == "/":
            body = HTML.replace("{{users}}", json.dumps([u.public() for u in USERS], ensure_ascii=False)).replace("{{now}}", json.dumps([n.public() for n in NOW_POSTS], ensure_ascii=False))
            self._send(200, body)
        elif path == "/health":
            self._send(200, json.dumps({"ok": True, "service": "NEAR", "docker": False}), "application/json; charset=utf-8")
        elif path == "/api/nearby":
            self._send(200, json.dumps([u.public() for u in USERS], ensure_ascii=False), "application/json; charset=utf-8")
        elif path == "/api/now":
            self._send(200, json.dumps([n.public() for n in NOW_POSTS], ensure_ascii=False), "application/json; charset=utf-8")
        elif path == "/api/chat":
            self._send(200, json.dumps([m.public() for m in MESSAGES], ensure_ascii=False), "application/json; charset=utf-8")
        else:
            self._send(404, "Not Found", "text/plain; charset=utf-8")

    def log_message(self, fmt, *args):
        return


def run() -> None:
    server = HTTPServer((HOST, PORT), Handler)
    print(f"NEAR prototype: http://{HOST}:{PORT}")
    server.serve_forever()


if __name__ == "__main__":
    run()
