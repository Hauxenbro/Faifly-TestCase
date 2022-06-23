# Faifly-TestCase

pip install -r requirements.txt


Database configuration: 

DB Name = 'Faifly'

Load Faifly.sql database.

URLs:

Admin-panel: 127.0.0.1:8080/faifly/admin_schedule/

login:admin
pass:123

API:

Worker list: 127.0.0.1:8080/faifly/workers/?spec=...&date=<y-m-d>

User unauthorisated only GET.
Authorisated GET, POST, PUT, DELETE, PATCH


Booking list: 127.0.0.1:8080/faifly/booking/?date=<y-m-d>

Staff user can see all records.
User unauthorised can't get any records from GET as answer, but can POST.
Authorised user see only records appropriate to his id.
