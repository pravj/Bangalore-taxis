Group by vehicle type
=====================

```
r.db('test').table('warehouse')
	.filter({available: true})
	.pluck('cab_id', 'type')
	.distinct()
	.group('type')
	.count()
```

Insertion of 'index' field
==========================

```
r.db('test').table('warehouse').update({index: r.row('major').coerceTo("NUMBER").mul(4)})
r.db('test').table('warehouse').update({index: r.row('index').add(r.row('minor').coerceTo("NUMBER"))})
r.db('test').table('warehouse').update({index: r.row('index').add(-4)})
```

Cab count distribution by type (per quarter-hour)
=================================================

```
r.db('test').table('warehouse')
	.filter({available: true})
	.without('id', 'distance', 'duration', 'cab_lat', 'cab_lng', 'place_lat', 'place_lng')
	.distinct()
	.orderBy('index','cab_id')
	.group('index')
	.count()
```

Rise of the Guardians(Vehicles)
===============================

```
r.db('test').table('warehouse')
	.filter({available: true})
	.pluck('cab_id', 'cab_time')
	.distinct()
	.orderBy('cab_time')
```

The cab who stayed there
========================

> Co-ordinates of the cab, and the time when it moved last

```
r.db('test').table('warehouse')
	.filter({available: true})
	.group('cab_lat', 'cab_lng', 'cab_time')
	.count()
	.ungroup()
	.orderBy(r.desc('reduction'))
```

>

Apperance Defragmentation Graph (per cab)
=========================================

```
r.db('test').table('warehouse')
	.filter({available: true})
	.group('cab_id')
	.orderBy('index')
	.pluck('index')
	.distinct()
```

Cab which was spotted most
==========================

```
r.db('test').table('warehouse')
	.filter({available: true})
	.group('cab_id')
	.orderBy('index')
	.pluck('index')
	.distinct()
	.count()
	.ungroup()
	.orderBy(r.desc('reduction'))
```

Cab which travelled most
========================

```
r.db('test').table('warehouse')
	.filter({available: true})
	.without('id', 'place_lat', 'place_lng', 'duration', 'distance')
	.group('cab_id')
	.pluck('cab_lat', 'cab_lng', 'index', 'timestamp')
	.orderBy('index')
```

Cab distribution by location (per quarter-hour)
===============================================

```
r.db('test').table('warehouse')
  .filter({available: true})
  .group('cab_id', 'index')
  .nth(0)
  .pluck('cab_id', 'index', 'timestamp', 'cab_lat', 'cab_lng',' type')
  .ungroup()
  .orderBy(r.row('reduction')('index'))
```

Cab density index
=================

r.db('taxis').table('datacenter')
    .filter({available: true})
    .pluck('cab_lat', 'cab_lng')
    .distinct()
    .map(function(instance) {
        return r.circle(centerPoint, 2, {unit: 'mi'})
            .includes(r.point(instance('cab_lat'), instance('cab_lat')))
    })
    .count(true)