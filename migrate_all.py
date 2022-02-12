#!/bin/python

# Remember to run first
# databricks configure --token --profile oldWS
# databricks configure --token --profile newWS

import os

os.system(f'python export_db.py --profile oldWS --workspace --set-export-dir old-workspace')
os.system(f'python export_db.py --profile oldWS --download --set-export-dir old-workspace')
os.system(f'cd old-workspace && python ../import_db.py --profile newWS --workspace')


