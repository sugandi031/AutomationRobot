import os

def get_absolute_path(relative_path):
    base_path = os.path.dirname(os.path.abspath(__file__))
    return os.path.normpath(os.path.join(base_path, '..', relative_path))
