# Service-Oriented Software Assignment

This repository contains the complete university assignment developed for the course **Service-Oriented Software**.

The project consists of two parts:

1. **Part 1 – Lab Portal**  
   A Ruby on Rails web application for student collaboration, posts, contacts, private messaging, group conversations and instant notifications.

2. **Part 2 – Todo REST API**  
   A Ruby on Rails REST API that provides user authentication and management of Todos and Todo Items. The API was tested using automated tests and HTTPie and is documented using OpenAPI 3.0.

---

# Part 1 – Lab Portal

## Description

Lab Portal is a Ruby on Rails web application that provides a collaboration platform where students can communicate, publish posts, create personal contacts and form groups for laboratory projects.

## Features

### User Authentication

- User registration
- Local login using email and password
- Logout
- Usernames
- Authentication using Devise
- Google OAuth 2.0 login

### Posts

Users can:

- Create posts
- View posts from other users
- Search posts
- Filter posts by category
- View post details
- Delete their own posts

Post categories include:

- Programming
- Databases
- Networks
- Other

### Contacts

Users can:

- Browse registered users
- Add users to their personal contacts
- Remove users from their contacts
- Start private conversations with contacts

### Private Messaging

The application supports private communication between users.

Features include:

- One-to-one messaging
- Separate popup chat windows
- Message history
- Unread message indication
- Notifications for new messages

### Group Conversations

Users can create group conversations for laboratory teams.

Features include:

- Group creation
- Selection of multiple members
- Group message history
- Messages between all group members
- Notifications for new group messages

### Instant Notifications

Notifications are implemented using Rails Turbo Streams.

Users receive notifications for:

- New private messages
- New group messages

Notifications appear instantly without requiring a page refresh and can also be viewed from the Notifications page.

---

# Part 2 – Todo REST API

The second part of the assignment is located in:

```text
part2_api/
```

It is a Ruby on Rails API application that provides authentication and CRUD operations for Todos and Todo Items.

## Authentication

Authentication is implemented using Bearer tokens.

The API supports:

- User signup
- User login
- User logout
- Protected Todo and Item endpoints

## REST API Endpoints

### Authentication

| Method | Endpoint | Description |
|---|---|---|
| POST | `/signup` | Signup |
| POST | `/auth/login` | Login |
| GET | `/auth/logout` | Logout |

### Todos

| Method | Endpoint | Description |
|---|---|---|
| GET | `/todos` | List all todos and todo items |
| POST | `/todos` | Create a new todo |
| GET | `/todos/:id` | Get a todo |
| PUT | `/todos/:id` | Update a todo |
| DELETE | `/todos/:id` | Delete a todo and its items |

### Todo Items

| Method | Endpoint | Description |
|---|---|---|
| POST | `/todos/:id/items` | Create a new todo item |
| GET | `/todos/:id/items/:iid` | Get a todo item |
| PUT | `/todos/:id/items/:iid` | Update a todo item |
| DELETE | `/todos/:id/items/:iid` | Delete a todo item |

## Part 2 Models

The REST API contains three main models:

- `User`
- `Todo`
- `Item`

Their main relationships are:

```text
User 1 -------- * Todo
Todo 1 -------- * Item
```

Deleting a Todo also deletes its associated Items.

## Automated Tests

The API includes model and controller/integration tests.

Tests cover:

- User validation and authentication
- Signup
- Login
- Logout
- Authorization
- Todo creation
- Todo retrieval
- Todo update
- Todo deletion
- Item creation
- Item retrieval
- Item update
- Item deletion
- Invalid and unauthorized requests

Run all tests with:

```powershell
cd part2_api
rails test
```

Current test suite:

```text
28 runs
58 assertions
0 failures
0 errors
0 skips
```

## HTTPie Testing

The REST API was also manually tested using HTTPie.

Example login:

```powershell
python -m httpie POST http://localhost:3000/auth/login email="demo@restapi.com" password="123456"
```

Store the returned Bearer token:

```powershell
$token="YOUR_TOKEN"
```

Create a Todo:

```powershell
python -m httpie POST http://localhost:3000/todos "Authorization:Bearer $token" title="Complete REST API Assignment"
```

List Todos and their Items:

```powershell
python -m httpie GET http://localhost:3000/todos "Authorization:Bearer $token"
```

## OpenAPI / Swagger Documentation

The REST API is documented using **OpenAPI 3.0**.

The specification is located at:

```text
part2_api/docs/openapi.yaml
```

The file can be opened with Swagger Editor to inspect the API endpoints, request schemas, response schemas and Bearer authentication configuration.

---

# Technologies

Technologies used across the two parts include:

- Ruby 4.0.7
- Ruby on Rails 8.1.3.1
- SQLite
- Devise
- OmniAuth
- Google OAuth 2.0
- Hotwire
- Turbo Streams
- Stimulus
- HTML / ERB
- CSS
- REST
- JSON
- Bearer Token Authentication
- HTTPie
- Minitest
- OpenAPI 3.0 / Swagger
- Git
- GitHub

---

# Repository Structure

```text
lab_portal/
│
├── app/                 # Part 1 - Lab Portal application
├── config/
├── db/
├── test/
│
├── part2_api/           # Part 2 - Todo REST API
│   ├── app/
│   ├── config/
│   ├── db/
│   ├── docs/
│   │   └── openapi.yaml
│   └── test/
│
├── Gemfile
├── Gemfile.lock
└── README.md
```

---

# Installation

## Clone the Repository

```powershell
git clone https://github.com/MrHeadsh0t1/lab_portal.git
cd lab_portal
```

---

# Running Part 1 – Lab Portal

Install dependencies:

```powershell
bundle install
```

Prepare the database:

```powershell
rails db:create
rails db:migrate
```

Start the server:

```powershell
rails server
```

Open:

```text
http://localhost:3000
```

## Google OAuth Configuration

Google authentication requires a Google OAuth 2.0 Client ID and Client Secret.

For security reasons, these credentials are not stored in the repository.

On Windows PowerShell:

```powershell
$env:GOOGLE_CLIENT_ID="your_google_client_id"
$env:GOOGLE_CLIENT_SECRET="your_google_client_secret"
rails server
```

The environment variables must be configured in the same PowerShell session before starting the Rails server.

Local OAuth configuration:

```text
Authorized JavaScript origin:
http://localhost:3000

Authorized redirect URI:
http://localhost:3000/users/auth/google_oauth2/callback
```

---

# Running Part 2 – Todo REST API

From the repository root:

```powershell
cd part2_api
bundle install
rails db:create
rails db:migrate
rails server
```

The REST API will be available at:

```text
http://localhost:3000
```

Part 1 and Part 2 are separate Rails applications. Only one application should normally use port `3000` at a time.

To run the automated test suite:

```powershell
rails test
```

---

# Security

Part 1 authentication is handled using Devise and Google OAuth 2.0.

Part 2 uses password hashing and Bearer token authentication for protected API endpoints.

Sensitive Google OAuth credentials are loaded through environment variables and are not stored in the Git repository.

---

# Repository

GitHub repository:

```text
https://github.com/MrHeadsh0t1/lab_portal
```

---

# Author

**Vaios Koutsikos**

Developed for the university course **Service-Oriented Software**.