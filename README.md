===
brew install pyenv
pyenv install 3.11.9
pyenv global 3.11.9
===
python3 -m venv venv
source venv/bin/activate
===
pip install -r requirements.txt
===
python -c "import yaml; import RequestsLibrary; import JSONSchemaLibrary"
===

robot tests/test_auth_api.robot