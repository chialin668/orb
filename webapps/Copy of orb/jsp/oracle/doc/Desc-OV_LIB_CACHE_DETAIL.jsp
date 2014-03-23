<html>
<head>
	<title></title>
</head>

<body>
<P><u>OV_LIB_CACHE_DETAIL</u><u>:</u></P>
<ul>
  <li>Keep pin hit ratio close to 100% (or at least 95%)</li>
  <li>Keep reload ratio close to 0% </li>
  <li>If reload ratio &gt; 2%, increase SHARED_POOL_SIZE</li>
</ul>
<p>Column names:</p>
<ul>
  <li>namespace: Could be SQL AREA, TABLE/PROCEDURE, BODY, TRIGGER, INDEX,
    CLUSTER, OBJECT, or PIPE</li>
  <li>gets: The number of times a handle was requested for an item in the
    library cache</li>
  <li>gethits: The number of times a requested handle was already in cahce</li>
  <li>gethitratio:</li>
  <li>pins: The number of times an object (in the library cache) was executed</li>
  <li>pinhits: The executed object was already in cache</li>
  <li>pinhitratio:</li>
  <li>reloads: The number of times the object had to be reloaded into library
    cache because it's not there or it's aged out.</li>
  <li>reloadratio:</li>
</ul>
<p>NOTE:</p>
<ul>
  <li>Rewrite the SQLs</li>
  <li>&nbsp;</li>
</ul>


</body>
</html>