# URL Shortener - README

This application takes a full url and returns a short version that can be copied and shared. The shortend url will redirect the user to the full url. A custom slug may be specified, but is not required.

## Running the application

This application is set to run locally on `localhost:3000`. To use a different
host (or port), please edit the `ENV['HOST']` in
`config/environments/development.rb`

**Setup**

```
bundle install
bundle exec rake db:setup
```

**Run the webserver**

```
rails s
```

## Testing

The test suite uses RSpec. To run the specs run

```
bundle exec rspec
```

## Usage

Shortened URLs can be entered directly into the browser and will redirect to
the corresponding long URL

### Using the API

**Routing**

```
GET    /api/short_urls
GET    /api/short_urls/:id
POST   /api/short_urls
PATCH  /api/short_urls/:id
PATCH  /api/short_urls/:id/expire
DELETE /api/short_urls/:id
```

**Sample Request Body**

```
{
  "short_url": {
    "original": "https://artsandculture.google.com/asset/street-in-r%C3%B8ros-in-winter-harald-sohlberg/FgHuU7rbjfysSw?hl=en"
  }
}
```

**Sample Response Body**

```
{
  "id": 5,
  "original": "https://artsandculture.google.com/asset/street-in-r%C3%B8ros-in-winter-harald-sohlberg/FgHuU7rbjfysSw?hl=en",
  "slug": "ux1omHK9FA1EZESX",
  "sharing_url": "http://localhost:3000/ux1omHK9FA1EZESX",
  "created_at": "2020-04-22T02:35:17.579Z",
  "updated_at": "2020-04-22T02:35:17.579Z",
  "expired_at": null
}
```

**Permitted Attributes**
- _original_ - The full url to be shortened.

- _slug_ - A unique string identifying the shortened url. This will be auto-assigned using SecureRandom if left blank.

- _expired_at_ - Datetime when the link was expired. The sharing_url is considered active when this value is null. This value will be set to the current time when using the expire route unless the url is already expired.
