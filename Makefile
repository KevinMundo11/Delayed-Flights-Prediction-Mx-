#################################################################################
# GLOBALS                                                                       #
#################################################################################

PROJECT_NAME = Delayed_Flights_Prediction_Mx
PYTHON_VERSION = 3.10
PYTHON_INTERPRETER = python

#################################################################################
# COMMANDS                                                                      #
#################################################################################


## Install Python Dependencies
.PHONY: requirements
requirements:
	conda env update --name $(PROJECT_NAME) --file environment.yml --prune
	



## Delete all compiled Python files
.PHONY: clean
clean:
	find . -type f -name "*.py[co]" -delete
	find . -type d -name "__pycache__" -delete

## Lint using flake8 and black (use `make format` to do formatting)
.PHONY: lint
lint:
	flake8 delayed_flights_prediction_mx
	isort --check --diff --profile black delayed_flights_prediction_mx
	black --check --config pyproject.toml delayed_flights_prediction_mx

## Format source code with black
.PHONY: format
format:
	black --config pyproject.toml delayed_flights_prediction_mx






#################################################################################
# PROJECT RULES                                                                 #
#################################################################################


## Make Dataset
.PHONY: data
data: requirements
	$(PYTHON_INTERPRETER) delayed_flights_prediction_mx/dataset.py


#################################################################################
# Self Documenting Commands                                                     #
#################################################################################

.DEFAULT_GOAL := help

define PRINT_HELP_PYSCRIPT
import re, sys; \
lines = '\n'.join([line for line in sys.stdin]); \
matches = re.findall(r'\n## (.*)\n[\s\S]+?\n([a-zA-Z_-]+):', lines); \
print('Available rules:\n'); \
print('\n'.join(['{:25}{}'.format(*reversed(match)) for match in matches]))
endef
export PRINT_HELP_PYSCRIPT

help:
	@$(PYTHON_INTERPRETER) -c "${PRINT_HELP_PYSCRIPT}" < $(MAKEFILE_LIST)
