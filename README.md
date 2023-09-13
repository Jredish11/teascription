# README





# Teascription


<a id="readme-top"></a>

<!-- PROJECT SHIELDS -->


[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]




<h3 align="center">Teascription</h3>

  <p align="center">
    Welcome to the back end repository for Teascription!
    Teascription is a backend API for managing tea subscriptions. Built for the Turing School of Software and Design's Mod 4 Take Home Code.
  </p>
</div>
<br>



<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#description-of-this-app">Description of this App</a>
      <ul>
        <li><a href="#built-with">Built With</a></li>
      </ul>
    </li>
    <li><a href="#Project Contributor Contact Info">Project Contributor Contact Info</a></li>
    <li>
      <a href="#getting-started">Getting Started</a>
        <li><a href="#prerequisites">Prerequisites</a></li>
    </li>
    <li><a href="#testing">Testing</a></li>
    <li><a href="#api-json-contract">API JSON Contract</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#license">License</a></li>
  </ol>
</details>


## Description of this App

Teascription is a backend API for managing tea subscriptions, providing CRUD (Create, Read, Update, Delete) operations.

Subscription Creation: Users can create new subscriptions.
Subscription Deletion: Users have the ability to cancel or delete their subscriptions.
Viewing Subscriptions: Users can view a list of all subscriptions, including both active and canceled ones. 
Reactivating Subscriptions: There is functionality to reactivate canceled subscriptions. Users can potentially change their minds and decide to resume subscriptions for tea products.
Database Management: The app manages data related to customers, subscriptions, and teas in a PostgreSQL database. It establishes relationships between these models to track customer-subscription and tea-subscription associations.
 
<br>

Github repositories:

* Teascription repo:  [![Github][Github]][project-be-gh-url]


<!-- <p align="right">(<a href="#readme-top">back to top</a>)</p> -->

### Built With

* [![Ruby][Ruby]][Ruby-url]
* [![Rails][Rails]][Rails-url]
* [![Postgres][Postgres]][Postgres-url]
* ![Postman](https://img.shields.io/badge/Postman-FF6C37?style=for-the-badge&logo=postman&logoColor=white)
* ![Github Pages](https://img.shields.io/badge/github%20pages-121013?style=for-the-badge&logo=github&logoColor=white)


Teascription uses these integrations:




## Project Contributor Contact Info
* Jeff Redish:   [![Linkedin][Linkedin-shield]][jeff-li-url] [![Github][Github]][jeff-gh-url]



## Getting Started

  <h3> How to install the project?</h3>

- Fork and clone this repo
- Run `bundle install`
- Run `rails db:{drop,create,migrate,seed}`
- Use `bundle exec rspec` to run the test suite
### Prerequisites

* ruby 3.2.2
* Rails Version 7.0.6


<!-- Testing -->
## Testing

`bundle exec rspec` will run the entire test suite. *All tests passing at time of writing.*


---
[Back to Top](#readme-top)

# DB Diagram:

<iframe width="560" height="315" src='https://dbdiagram.io/embed/65009d4f02bd1c4a5e703cdd'> </iframe>

<br> 

- One customer can have multiple subscriptions
- One tea can be associated with multiple subscriptions
- Many subscriptions can belong to one customer
- Many subscriptions can be associated with one tea


# API JSON Contract

Description of API request endpoints for front end application

### POST: Create a Subscription

`POST /api/v1/places/subscriptions`

(while running rails s in terminal)<br>
postman request url:  http://localhost:3000/api/v1/subscriptions <br>
Click Body tab and select raw to enter this data(make sure JSON selected)
```json
{
  "subscription": {
    "title": "Earl Grey",
    "price": 5.00,
    "frequency": "monthly",
    "customer_id": 10,
    "tea_id": 3
  }
}
```


Success Response (200 OK):

- Status: 200 OK
- Description: Successful response with a created subscription object.
- Data Format: A data array, with keys "id", "type" and "attributes".
```json
{
    "data": {
        "id": "14",
        "type": "subscription",
        "attributes": {
            "id": 14,
            "title": "Earl Grey",
            "price": 5.0,
            "frequency": "monthly",
            "customer_id": 10,
            "tea_id": 3,
            "deleted_at": null
        }
    }
}
```

Error Response (422 Unprocessable Entity):

- Description: The requested subscription can't be created because a customer must exist.
- Data Format: Error message for human.
- Status: 422 Unprocessable Entity
```json
{
    "error": "Customer must exist"
}

```

### Delete a Subscription

`DELETE /api/v1/subscriptions/:id`<br>
- (while running rails s in terminal)
- postman url request: http://localhost:3000/api/v1/subscriptions/{id}
- id has to exist


Success Response (200 OK):

- Status: 200 OK
- Description: Successful response with message that Subscription has been successfully deleted.
- Data Format: A data hash with message for human
```json
{
    "message": "Subscription successfully deleted"
}
```

Error Response (404 Not Found):

- Description: The requested subscription was not found.
- Data Format: Error message for human.
- Status: 404 Not Found
```json
{
    "status": 404,
    "error": "Not Found",
    "exception": "#<ActiveRecord::RecordNotFound: Couldn't find Subscription with 'id'=11 [WHERE \"subscriptions\".\"deleted_at\" IS NULL]>" }
```

### GET list of all Subscriptions (Active & Cancelled)

`GET /api/v1/subscriptions`<br>
- (while running rails s in terminal)
- postman url request: http://localhost:3000/api/v1/subscriptions



Success Response (200 OK):

- Status: 200 OK
- Description: Successful response with message that Subscription has been successfully deleted.
- Data Format: A data array with a list of Subscription records, Active Subscriptions having a value of null for the "deleted_at" column.
```json
[
    {
        "id": 5,
        "title": "Earl Grey",
        "price": 5.0,
        "frequency": "monthly",
        "customer_id": 5,
        "tea_id": 3,
        "created_at": "2023-09-12T21:31:41.655Z",
        "updated_at": "2023-09-12T21:31:41.655Z",
        "deleted_at": null,
        "status": null
    },
    {
        "id": 6,
        "title": "Earl Grey",
        "price": 5.0,
        "frequency": "monthly",
        "customer_id": 5,
        "tea_id": 3,
        "created_at": "2023-09-12T21:31:43.418Z",
        "updated_at": "2023-09-12T21:31:43.418Z",
        "deleted_at": null,
        "status": null
    },
    {
        "id": 3,
        "title": "Earl Grey",
        "price": 5.0,
        "frequency": "monthly",
        "customer_id": 5,
        "tea_id": 3,
        "created_at": "2023-09-12T21:29:30.284Z",
        "updated_at": "2023-09-13T02:34:57.462Z",
        "deleted_at": "2023-09-13T02:34:57.462Z",
        "status": null
    },
    {
        "id": 4,
        "title": "Earl Grey",
        "price": 5.0,
        "frequency": "monthly",
        "customer_id": 5,
        "tea_id": 3,
        "created_at": "2023-09-12T21:31:36.838Z",
        "updated_at": "2023-09-13T02:35:17.260Z",
        "deleted_at": "2023-09-13T02:35:17.260Z",
        "status": null
    },
    {
        "id": 8,
        "title": "Earl Grey",
        "price": 5.0,
        "frequency": "monthly",
        "customer_id": 6,
        "tea_id": 3,
        "created_at": "2023-09-13T17:36:33.327Z",
        "updated_at": "2023-09-13T17:37:30.704Z",
        "deleted_at": "2023-09-13T17:37:30.704Z",
        "status": null
    },
    {
        "id": 9,
        "title": "Earl Grey",
        "price": 5.0,
        "frequency": "monthly",
        "customer_id": 5,
        "tea_id": 3,
        "created_at": "2023-09-13T20:17:51.893Z",
        "updated_at": "2023-09-13T20:17:51.893Z",
        "deleted_at": null,
        "status": null
    },
    {
        "id": 10,
        "title": "Earl Grey",
        "price": 5.0,
        "frequency": "monthly",
        "customer_id": 10,
        "tea_id": 10,
        "created_at": "2023-09-13T20:21:51.255Z",
        "updated_at": "2023-09-13T20:21:51.255Z",
        "deleted_at": null,
        "status": null
    },
    {
        "id": 11,
        "title": "Earl Grey",
        "price": 5.0,
        "frequency": "monthly",
        "customer_id": 10,
        "tea_id": 3,
        "created_at": "2023-09-13T20:29:43.142Z",
        "updated_at": "2023-09-13T20:47:35.448Z",
        "deleted_at": "2023-09-13T20:47:35.448Z",
        "status": null
    }
]
```
<!-- Roadmap -->
## Roadmap
Additional features, functionality, and potential refactors:
  * Consume external API to bring in more data for different teas. Save endpoint requests data to local DB.


[Back to Top](#readme-top)

<!-- CONTACT -->

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/jredish11/teascription.svg?style=for-the-badge
[contributors-url]: https://github.com/jredish11/teascription/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/jredish11/teascription.svg?style=for-the-badge
[forks-url]: https://github.com/jredish11/teascription/network/members
[stars-shield]: https://img.shields.io/github/stars/jredish11/teascription.svg?style=for-the-badge
[stars-url]: https://github.com/jredish11/teascription/stargazers
[issues-shield]: https://img.shields.io/github/issues/jredish11/teascription.svg?style=for-the-badge
[issues-url]: https://github.com/jredish11/teascription/issues
[license-shield]: https://img.shields.io/github/license/jredish11/teascription.svg?style=for-the-badge
[license-url]: https://github.com/jredish11/teascription/blob/main/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white
[jeff-li-url]: https://www.linkedin.com/in/jredish/
[Github]: https://img.shields.io/badge/GitHub-100000?style=for-the-badge&logo=github&logoColor=white
[project-be-gh-url]: https://github.com/jredish11/teascription
[jeff-gh-url]: https://github.com/Jredish11
[Ruby]: https://img.shields.io/badge/Ruby-CC342D?style=for-the-badge&logo=ruby&logoColor=white
[Ruby-url]: https://www.ruby-lang.org/en/
[Rails]: https://img.shields.io/badge/Ruby_on_Rails-CC0000?style=for-the-badge&logo=ruby-on-rails&logoColor=white
[Rails-url]: https://rubyonrails.org/
[Postgres]: https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white
[Postgres-url]: https://www.postgresql.org/

