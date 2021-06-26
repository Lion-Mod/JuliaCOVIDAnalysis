using DataFrames
using CSV
using Chain
using Plots


function get_and_read_COVID_data(url::String, filename::String)
    download(url, filename)
    return DataFrame(CSV.File(filename))
end

function rename_columns(df::DataFrame)
    return @chain df begin
        rename!(1 => "province",
                2 => "country",
                3 => "latitude",
                4 => "longitude")
    end
end

function filter_to_and_pivot_US_data(df::DataFrame)
    return @chain df begin
        filter(col -> col.country == "US", _)[:, 5:end]
        stack(_, names(_))
    end
end

url = "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv";

data = get_and_read_COVID_data(url, "covid_data.csv");
tidy_data = rename_columns(data)
US_data = filter_to_and_pivot_US_data(tidy_data)


# Plot on log scale
plot(log.(US_data[:, 2]))