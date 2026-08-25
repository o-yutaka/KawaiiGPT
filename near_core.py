"""NEAR core domain primitives.

Docker-free, dependency-free foundation used by the local prototype.
The public client model intentionally never exposes raw GPS coordinates.
"""
from __future__ import annotations

from dataclasses import dataclass, asdict
from datetime import datetime, timezone
from math import atan2, cos, radians, sin, sqrt
from typing import Iterable


@dataclass(frozen=True)
class NearbyUser:
    user_id: str
    name: str
    age: int
    interests: tuple[str, ...]
    distance_m: int
    activity: str
    recent_label: str | None = None
    now_preview: str | None = None
    verified: bool = False

    def public(self) -> dict:
        return asdict(self)


@dataclass(frozen=True)
class NowPost:
    post_id: str
    user_id: str
    name: str
    area_label: str
    text: str
    created_at: str
    expires_at: str

    def public(self) -> dict:
        return asdict(self)


@dataclass(frozen=True)
class Message:
    message_id: str
    sender: str
    text: str
    created_at: str

    def public(self) -> dict:
        return asdict(self)


def utc_now() -> datetime:
    return datetime.now(timezone.utc)


def haversine_m(lat1: float, lon1: float, lat2: float, lon2: float) -> float:
    r = 6_371_000.0
    p1, p2 = radians(lat1), radians(lat2)
    dp = radians(lat2 - lat1)
    dl = radians(lon2 - lon1)
    a = sin(dp / 2) ** 2 + cos(p1) * cos(p2) * sin(dl / 2) ** 2
    return 2 * r * atan2(sqrt(a), sqrt(max(0.0, 1 - a)))


def rank_nearby(users: Iterable[NearbyUser]) -> list[NearbyUser]:
    """Closest-first ranking with activity/trust tie-breakers."""
    activity_weight = {"LIVE": 0, "JUST NOW": 1, "RECENT": 2, "OFFLINE": 3}
    return sorted(
        users,
        key=lambda u: (
            max(0, u.distance_m),
            activity_weight.get(u.activity, 9),
            not u.verified,
            u.name.lower(),
        ),
    )


def safe_recent_label(minutes_ago: int) -> str:
    minutes_ago = max(1, int(minutes_ago))
    return f"{minutes_ago}分前にこの周辺"
