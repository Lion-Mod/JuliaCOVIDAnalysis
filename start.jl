using DataFrames
using CSV
using Chain
using Plots


function getAndReadCovidData(url::String, filename::String)
    download(url, filename)
    return DataFrame(CSV.File(filename))
end

function renameColumns(df::DataFrame)
    return @chain df begin
        rename!(1 => "province",
                2 => "country",
                3 => "latitude",
                4 => "longitude")
    end
end

function filterToAndPivotUSData(df::DataFrame)
    return @chain df begin
        filter(col -> col.country == "US", _)[:, 5:end]
        stack(_, names(_))
    end
end

url = "https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv"

data = getAndReadCovidData(url, "covid_data.csv");
tidy_data = renameColumns(data)
US_data = filterToAndPivotUSData(tidy_data)


# Plot on log scale
plot(log.(US_data[:, 2]))