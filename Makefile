# Define variables
VENV_DIR = venvOTC
PYTHON = $(VENV_DIR)/bin/python
PIP = $(VENV_DIR)/bin/pip

# List of Python packages to install
PYTHON_PACKAGES = nltk spacy transformers selenium datasets chardet huggingface_hub pyarrow scikit-learn pandas matplotlib 

# Create virtual environment
$(VENV_DIR):
	python3 -m venv $(VENV_DIR)

# Install dependencies
install: $(VENV_DIR)
	$(PIP) install --upgrade pip
	$(PIP) install $(PYTHON_PACKAGES)

# Download NLTK data
nltk_data: $(VENV_DIR)
	$(PYTHON) -m nltk.downloader all

# Download SpaCy model
spacy_model: $(VENV_DIR)
	$(PYTHON) -m spacy download en_core_web_sm

# Update all packages to the latest version
update_packages: $(VENV_DIR)
	$(PIP) install --upgrade pip
	$(PIP) list --outdated | findstr /V "Package" | findstr /V "------" | findstr /V "Up-to-date" | for /F "tokens=1" %i in ('more') do $(PIP) install --upgrade %i

# Set up the environment
setup: install nltk_data spacy_model

# Run tests
test: $(VENV_DIR)
	$(PYTHON) -m unittest discover -s tests

# Clean environment
clean:
	rm -rf $(VENV_DIR)

.PHONY: install nltk_data spacy_model setup test clean
