SELECT
  event_timestamp,
  event_name,
  (SELECT
    value.string_value
  FROM
    `home-automation-project-001.analytics_314144287.events_intraday_*`,
    UNNEST(event_params) AS params
  WHERE
    key = 'device'
    AND event_timestamp = base.event_timestamp ) AS device_type,

  (SELECT
    CASE
      WHEN value.string_value IS NOT NULL THEN value.string_value
    END AS device_state_string
  FROM
    `home-automation-project-001.analytics_314144287.events_intraday_*`,
    UNNEST(event_params) AS params
  WHERE
    key = 'state'
    AND event_timestamp = base.event_timestamp ) AS device_state_string,

  (SELECT
    CASE
      WHEN value.int_value IS NOT NULL THEN value.int_value
    END AS device_state_int
  FROM
    `home-automation-project-001.analytics_314144287.events_intraday_*`,
    UNNEST(event_params) AS params
  WHERE
    key = 'state'
    AND event_timestamp = base.event_timestamp ) AS device_state_int,

  (SELECT
    CASE
      WHEN value.double_value IS NOT NULL THEN value.double_value
    END AS device_state_double
  FROM
    `home-automation-project-001.analytics_314144287.events_intraday_*`,
    UNNEST(event_params) AS params
  WHERE
    key = 'state'
    AND event_timestamp = base.event_timestamp ) AS device_state_double,

  (SELECT
    CASE
      WHEN value.float_value IS NOT NULL THEN value.float_value
    END AS device_state_float
  FROM
    `home-automation-project-001.analytics_314144287.events_intraday_*`,
    UNNEST(event_params) AS params
  WHERE
    key = 'state'
    AND event_timestamp = base.event_timestamp ) AS device_state_float
FROM
  `home-automation-project-001.analytics_314144287.events_intraday_*` AS base
