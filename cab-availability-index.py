# -*- coding: utf-8 -*-

"""
Used to calculate the 'cab availability index'
"""

import rethinkdb as r
import json

try:
	with open('active.json', 'r') as actives:
		active_data = json.load(actives)
except Exception, e:
	raise e

try:
    conn = r.connect(host='localhost', port=28015)
    conn.repl()
except:
    print 'RethinkDB : Connection Problem'
    sys.exit(1)

stats = []

index = 0
for place in active_data:
	circle = r.circle([float(place['lng'].encode('ascii','ignore')), float(place['lat'].encode('ascii','ignore'))], 3169, unit='m')
	response = r.db('test').table('warehouse').filter(lambda instance: instance['available'] == True).pluck('cab_lat', 'cab_lng').distinct().map(lambda instance: circle.includes(r.point(instance['cab_lng'].coerce_to('number'),instance['cab_lat'].coerce_to('number')))).run()

	t = 0

	for res in response:
		if res:
			t += 1

	index += 1

	stats.append({'lat': place['lat'].encode('ascii','ignore'), 'lng': place['lng'].encode('ascii','ignore'), 'count': t})

print stats
