from drain.data import FromSQL

facilities = FromSQL('select rcra_id, zip_code from output.facilities', tables=['output.facilities'])
facilities.target=True
