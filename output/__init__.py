from drain.data import FromSQL

facilities = FromSQL("""
select rcra_id, zip_code, dedupe_id as entity_id 
from output.facilities 
join dedupe.unique_map using (rcra_id)
""", tables=['output.facilities', 'output.handler_names'])
facilities.target=True
