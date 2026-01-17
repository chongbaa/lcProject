"""
Project entry point.
This file should remain thin and only coordinate high‑level startup logic.
"""

from myapp import create_app


def main():
    """
    Main entry function.
    Keep this minimal: initialize, configure, and run the application.
    """
    app = create_app()
    app.run()


if __name__ == "__main__":
    main()

