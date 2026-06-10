import atexit
import os

try:
    import readline
    historyPath = os.path.expanduser("~/.pdb_history")
    readline.clear_history()
    if os.path.exists(historyPath):
        readline.read_history_file(historyPath)

    def save_history(historyPath=historyPath):
        import readline
        readline.write_history_file(historyPath)

    atexit.register(save_history)
except ImportError:
    pass
