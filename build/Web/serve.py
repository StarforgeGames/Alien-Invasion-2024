""" Serves the Godot game in a local HTTP server """
from http.server import HTTPServer, SimpleHTTPRequestHandler, test  # type: ignore
from pathlib import Path
import os
import sys
import argparse
import subprocess


class CORSRequestHandler(SimpleHTTPRequestHandler):
    """
    To ensure low audio latency and the ability to use Thread in web exports, Godot 4 web exports
    always use SharedArrayBuffer. This requires a secure context, while also requiring the following
    CORS headers to be set when serving the files.
    """

    def end_headers(self):
        self.send_header("Cross-Origin-Opener-Policy", "same-origin")
        self.send_header("Cross-Origin-Embedder-Policy", "require-corp")
        self.send_header("Access-Control-Allow-Origin", "*")
        super().end_headers()


def shell_open(url):
    """Opens the web browser"""
    if sys.platform == "win32":
        os.startfile(url)
    else:
        opener = "open" if sys.platform == "darwin" else "xdg-open"
        subprocess.call([opener, url])


def serve(root, port, run_browser):
    """Serves the HTML files"""
    os.chdir(root)

    if run_browser:
        # Open the served page in the user's default browser.
        print(
            "Opening the served URL in the default browser "
            + "(use `--no-browser` or `-n` to disable this)."
        )
        shell_open(f"http://localhost:{port}")

    test(CORSRequestHandler, HTTPServer, port=port)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument(
        "-p", "--port", help="port to listen on", default=8060, type=int
    )
    parser.add_argument(
        "-r",
        "--root",
        help="path to serve as root (relative to `platform/web/`)",
        default="../../bin",
        type=Path,
    )
    browser_parser = parser.add_mutually_exclusive_group(required=False)
    browser_parser.add_argument(
        "-n",
        "--no-browser",
        help="don't open default web browser automatically",
        dest="browser",
        action="store_false",
    )
    parser.set_defaults(browser=True)
    args = parser.parse_args()

    # Change to the directory where the script is located,
    # so that the script can be run from any location.
    os.chdir(Path(__file__).resolve().parent)

    serve(args.root, args.port, args.browser)
