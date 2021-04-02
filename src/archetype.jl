# set of predefined use-case archetype

# interaction events
# generate website traffic dataset. Format is either GA, Heap, or Amplitude formats
function gen_traffic(days::String, shape::String) end
function gen_traffic_visitors() end
function gen_traffic_sessions(days::String, shape::String;
    flavour::String = "GA",
    channels::AbstractArray = ["direct", "paid", "email", "referral", "affiliate", "organic"],
    n_anomalies::Integer = 5,
    seasonality::String = "fiveeyes") end
function gen_traffic_events() end

# transactional data
function gen_sales() end
function gen_subscriptions() end
function gen_invoices() end

# customers
function gen_users() end
function gen_subscribers() end

# products
function gen_products() end
function gen_categories() end
function gen_subscription_plans() end
