# -*- coding: utf-8 -*-
'''Configuration constants.
'''
#
# library imports
#
import logging
#
# module version--kept in its own file for setup.py
#
from .version import version as __version__ # noqa
#
# global constants
#
PROGRAM_NAME = 'lorax'
AUTHOR = 'Joel Berendzen'
EMAIL = 'joelb@ncgr.org'
COPYRIGHT = """Copyright (C) 2017, The National Center for Genome Resources.  All rights reserved.
"""
PROJECT_HOME = 'https://github.com/LegumeFederation/lorax'
DOCS_HOME = 'https://lorax.readthedocs.org/en/stable'
DEFAULT_FILE_LOGLEVEL = logging.DEBUG
DEFAULT_STDERR_LOGLEVEL = logging.INFO
VERSION = __version__
CONFIGFILE_NAME = 'config.json'
TREEBUILDERS = ['FastTree', 'RAxML']
DIR_MODE = 0o755
PEPTIDE_PART = 'peptide'
DNA_PART = 'DNA'
PEPTIDE_EXT = '.faa'
DNA_EXT = '.fna'
ALIGNMENT_NAME = 'alignment'
DNA_FILENAME = ALIGNMENT_NAME + DNA_EXT
PEPTIDE_FILENAME = ALIGNMENT_NAME + PEPTIDE_EXT
SEQUENCES_NAME = 'sequences'
TREE_NAME = 'tree.nwk'
SEQUENCE_DATA_FILENAME = 'sequence_data.json'
HMM_FILENAME = 'family.hmm'