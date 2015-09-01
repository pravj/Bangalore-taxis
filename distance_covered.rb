require 'geokit'
require 'json'

distance_data = open('distance.json').read()
distance_json = JSON.parse(distance_data)

max = 0
max_cab = ''

distance_json.each do |cab|

	initial_lat, initial_lng = cab['reduction'][0]['cab_lat'], cab['reduction'][0]['cab_lng']
	distance = 0
	last_time = cab['reduction'][0]['timestamp']

	cab['reduction'].each do |place|
		if (place['timestamp'] != last_time)
			a = Geokit::LatLng.new(initial_lat, initial_lng)
			b = Geokit::LatLng.new(place['cab_lat'], place['cab_lng'])

			distance = distance + a.distance_to(b)
			initial_lat, initial_lng = place['cab_lat'], place['cab_lng']

			last_time = place['timestamp']
		end
	end

	if (distance >= max)
		max = distance
		max_cab = cab['group']
	end

	if (cab['group'] == first_cab)
		first_cab_distance = distance
	end
end

puts max
puts max_cab
