# Faifly-TestCase


Database configuration: 

DB Name = 'Faifly'
User = 'root'
password = '12345'

URLs:

Admin-panel: 127.0.0.1:8080/faifly/admin_schedule/

API:

Worker list: 127.0.0.1:8080/faifly/workers/?spec=...&date=<y-m-d>

user unauthorisated only GEt
authorisated GET, POST, PUT, DELETE, PATCH


Booking list: 127.0.0.1:8080/faifly/booking/?starting_date=<y-m-d>

staff user can see all records
user unauthorised can't get any records from GET as answer, but can POST
authorised user see only records appropriate to his id.
