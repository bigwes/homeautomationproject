-- ****** get all events ******
SELECT
  event_name,
  event_timestamp,
  params.key AS event_parameter_key,
  CASE
    WHEN params.value.string_value IS NOT NULL THEN 'string'
    WHEN params.value.int_value IS NOT NULL THEN 'int'
    WHEN params.value.double_value IS NOT NULL THEN 'double'
    WHEN params.value.float_value IS NOT NULL THEN 'float'
  END AS event_parameter_type,
  params.value.string_value AS event_parameter_string_value,
  params.value.int_value AS event_parameter_int_value,
  params.value.double_value AS event_parameter_double_value,
  params.value.float_value AS event_parameter_float_value
FROM
  `home-automation-project-001.analytics_314144287.events_intraday_20220506`,
  UNNEST(event_params) AS params
WHERE 
  params.key = 'device' -- or params.key = 'state'
GROUP BY
  1, 2, 3, 4, 5, 6, 7, 8
ORDER BY
  4, 1

-- ****** get specific event type with timestamp ******
SELECT timestamp_micros(event_timestamp), event_name, device_name, device_state FROM(
SELECT
  event_name,
  event_timestamp,
  device.key AS event_parameter_key,
  device.value.string_value AS device_name,
  state.value.double_value AS device_state
FROM
  `home-automation-project-001.analytics_314144287.events_intraday_*`,
  UNNEST(event_params) AS device,
  UNNEST(event_params) AS state
GROUP BY
  1, 2, 3, 4, 5)
where event_name = 'temperature'
and device_name is not null
and device_state is not null
order by device_name, event_timestamp
