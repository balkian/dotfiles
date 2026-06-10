import os
import pdb

try:
    import readline

    historyPath = os.path.expanduser("~/.pdb_history")
    readline.set_history_length(1000)
    readline.clear_history()
    if os.path.exists(historyPath):
        try:
            readline.read_history_file(historyPath)
        except OSError:
            pass

    class PdbWithHistory(pdb.Pdb):
        def default(self, line):
            readline.append_history_file(1, historyPath)
            return super().default(line)

        def cmdloop(self, intro=None):
            try:
                super().cmdloop(intro)
            finally:
                try:
                    readline.write_history_file(historyPath)
                except OSError:
                    pass

    pdb.Pdb = PdbWithHistory

except ImportError:
    pass
