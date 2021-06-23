"""Convert pacific time to eastern."""

from datetime import datetime, timedelta

est = datetime.now() + timedelta(hours=3)
print(est.strftime("%I:%M %p (eastern)"))
