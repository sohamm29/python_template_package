from src.main import main


def test_main_prints_greeting(capsys):
    """Placeholder test so the suite is never empty. Replace with real tests."""
    main()
    captured = capsys.readouterr()
    assert "Hello from glintt-next-template!" in captured.out
