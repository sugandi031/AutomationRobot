import yaml
import os

def load_yaml(file_path):
    """Load YAML file and return as Python dictionary."""
    if not os.path.exists(file_path):
        raise FileNotFoundError(f"File not found: {file_path}")
    
    with open(file_path, 'r') as f:
        return yaml.safe_load(f)

def save_yaml(data, file_path):
    """Save Python dictionary to a YAML file."""
    with open(file_path, 'w') as f:
        yaml.dump(data, f, default_flow_style=False, sort_keys=False)

def update_section(file_path, section, key, value):
    """
    Update a section (headers or body) in the YAML file.
    """
    data = load_yaml(file_path)
    if section not in data:
        data[section] = {}
    data[section][key] = value
    save_yaml(data, file_path)

def update_header(file_path, key, value):
    update_section(file_path, 'headers', key, value)

def update_body(file_path, key, value):
    update_section(file_path, 'body', key, value)
