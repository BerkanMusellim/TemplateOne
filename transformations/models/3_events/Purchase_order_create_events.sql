with Purchase_orders as (
    select * from {{ ref('Purchase_orders') }}
),

/* Create events are defined based on the creation timestamp on the entity table.
Every entity has exactly one create event. */
Purchase_order_create_events as (
    select
        -- Mandatory event fields
        Purchase_orders."Purchase_order_ID",
        {{ pm_utils.as_varchar('Create purchase order') }} as "Activity",
        Purchase_orders."Created_at" as "Event_end",
        -- Optional event fields
        Purchase_orders."Creator",
        Purchase_orders."Team"
    from Purchase_orders
)

select * from Purchase_order_create_events
