# Welcome to the URL Shortener

<br>
## Running the application

This application is set to run locally on `localhost:3000`. To use a different
port, please edit the `ENV['HOST']` in `config/environments/development.rb`

To start the application run

```
rails s
```

<br>
## Testing

The test suite uses RSpec. To run the specs run

```
bundle exec rspec
```

<br>
## Usage

Shortened URLs can be entered directly into the browser and will redirect to
the corresponding long URL

### Using the API

**Routing**
<table class='code-table'>
  <tbody>
    <tr>
      <td>`GET`</td>
      <td>`/api/short_urls`</td>
    </tr>
    <tr>
      <td>`GET`</td>
      <td>`/api/short_urls/:id`</td>
    </tr>
    <tr>
      <td>`POST`</td>
      <td>`/api/short_urls`</td>
    </tr>
    <tr>
      <td>`PATCH`</td>
      <td>`/api/short_urls/:id`</td>
    </tr>
    <tr>
      <td>`PATCH`</td>
      <td>`/api/short_urls/:id/expire`</td>
    </tr>
    <tr>
      <td>`DELETE`</td>
      <td>`/api/short_urls/:id`</td>
    </tr>
  </tbody>
</table>


**Sample Request Body**
<div class='pretty-json'>
  {
    <div>
      "short_url": {
        <div>
          "original": "https://artsandculture.google.com/asset/street-in-r%C3%B8ros-in-winter-harald-sohlberg/FgHuU7rbjfysSw?hl=en"
        </div>
      }
    </div>
  }
</div>

**Response Body**

<div class='pretty-json'>
  {
    <div>
      "id": 5,<br>
      "original": "https://artsandculture.google.com/asset/street-in-r%C3%B8ros-in-winter-harald-sohlberg/FgHuU7rbjfysSw?hl=en",<br>
      "slug": "ux1omHK9FA1EZESX",<br>
      "sharing_url": "http://localhost:3000/ux1omHK9FA1EZESX",<br>
      "created_at": "2020-04-22T02:35:17.579Z",<br>
      "updated_at": "2020-04-22T02:35:17.579Z",<br>
      "expired_at": null
    </div>
  }
</div>

**Permitted Attributes**

<table class='code-table'>
  <thead>
    <tr>
      <th>Attribute</th>
      <th>Description</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td>original</td>
      <td>The full url to be shortened</td>
    </tr>
    <tr>
      <td>slug</td>
      <td>Unique string identifying the shortened url. This will be auto-assigned using SecureRandom if left blank</td>
    </tr>
    <tr>
      <td>expired_at</td>
      <td>
        Datetime when the link was expired. The sharing_url is considered active when this value is null. This value will be set to the current time when using the expire route unless the url is already expired.
      </td>
    </tr>
  </tbody>
</table>
