# Lab Portal

Lab Portal is a Ruby on Rails web application developed for the course
**Service-Oriented Software**.

The application provides a collaboration platform where students can
communicate, publish posts, create personal contacts and form groups for
laboratory projects.

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

Notifications appear instantly without requiring a page refresh and can
also be viewed from the Notifications page.

## Technologies

The project uses:

- Ruby
- Ruby on Rails
- SQLite
- Devise
- OmniAuth
- Google OAuth 2.0
- Hotwire
- Turbo Streams
- Stimulus
- HTML / ERB
- CSS
- Git
- GitHub

## Requirements

The development environment used for this project includes:

- Ruby 4.0.7
- Rails 8.1.3.1
- Git

## Installation

Clone the repository:

```bash
git clone https://github.com/MrHeadsh0t1/lab_portal.git
```

Enter the project directory:

```bash
cd lab_portal
```

Install the required gems:

```bash
bundle install
```

Create and migrate the database:

```bash
rails db:create
rails db:migrate
```

Start the Rails server:

```bash
rails server
```

Then open:

```text
http://localhost:3000
```

## Google OAuth Configuration

Google authentication requires a Google OAuth 2.0 Client ID and Client
Secret.

For security reasons, these credentials are not stored in the repository.

Before starting the application, configure the following environment
variables:

### Windows PowerShell

```powershell
$env:GOOGLE_CLIENT_ID="your_google_client_id"
$env:GOOGLE_CLIENT_SECRET="your_google_client_secret"
```

Then start Rails from the same PowerShell window:

```powershell
rails server
```

The Google OAuth application should use the following local configuration:

```text
Authorized JavaScript origin:
http://localhost:3000

Authorized redirect URI:
http://localhost:3000/users/auth/google_oauth2/callback
```

## Main Application Structure

```text
app/
├── controllers/
│   ├── contacts_controller.rb
│   ├── conversations_controller.rb
│   ├── messages_controller.rb
│   ├── notifications_controller.rb
│   ├── posts_controller.rb
│   └── users_controller.rb
│
├── models/
│   ├── contact.rb
│   ├── conversation.rb
│   ├── conversation_member.rb
│   ├── message.rb
│   ├── notification.rb
│   ├── post.rb
│   └── user.rb
│
├── views/
│   ├── conversations/
│   ├── devise/
│   ├── home/
│   ├── messages/
│   ├── notifications/
│   ├── posts/
│   └── users/
│
└── javascript/
    └── controllers/
```

## Database Models

The main models of the application are:

- User
- Post
- Contact
- Message
- Conversation
- ConversationMember
- Notification

The database structure is managed through Rails migrations.

## Security

Authentication is handled using Devise.

Google authentication is implemented using OmniAuth and Google OAuth 2.0.

Sensitive Google OAuth credentials are loaded through environment variables
and are not included in the Git repository.

Users must be authenticated to access the main application functionality.

## Repository

GitHub repository:

```text
https://github.com/MrHeadsh0t1/lab_portal
```

## Author

Vaios Koutsikos