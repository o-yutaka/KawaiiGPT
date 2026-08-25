"""NEAR development launcher.

No OS package manager, no Docker, no legacy KawaiiGPT dependency installer.
Run with a normal Python 3 installation.
"""
from __future__ import annotations

import os
import sys
import webbrowser


def main() -> int:
    print("=" * 56)
    print("NEAR v0.1 — Docker-free local prototype")
    print("=" * 56)
    print("Python:", sys.version.split()[0])
    print("Docker: not required")
    print()
    print("Starting http://127.0.0.1:8787")
    if os.environ.get("NEAR_NO_BROWSER") != "1":
        try:
            webbrowser.open("http://127.0.0.1:8787")
        except Exception:
            pass
    from near_app import run
    run()
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
