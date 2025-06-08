# Document Management System

## Overview

This is a Ruby on Rails application that allows users to upload, view, and manage documents based on their role. The system includes five user roles:

1. **SuperAdmin**
2. **Manager**
3. **Supervisor**
4. **Data Entry Operator (DEO)**
5. **Client**

## Application Flow

1. **SuperAdmin Creation**  
   - The SuperAdmin user is created automatically using the seed file (`rails db:seed`).  
   - This user has full control over the system and can manage all other users and roles.

2. **User Signup**  
   - When new users sign up, they are **assigned the role of "Client" by default**.  
   - Clients can upload and manage their own documents but have limited access compared to other roles.

3. **Role Management by SuperAdmin**  
   - The SuperAdmin can view all users (Managers, Supervisors, DEOs, Clients).  
   - The SuperAdmin can **change any user’s role** (e.g., promote a Client to Supervisor or assign a Manager).  
   - The SuperAdmin can assign hierarchical relationships:  
     - Assign Supervisors to Managers  
     - Assign Data Entry Operators to Supervisors and Managers  
     - Assign Clients to Data Entry Operators, Supervisors, and Managers

4. **Role-Based Access and Data Visibility**  
   - Based on their role and assignments, users have access to view and manage documents accordingly.  
   - For example, Managers can view documents uploaded by their assigned Clients.

---

## Features

- **Roles**: SuperAdmin, Manager, Supervisor, Data Entry Operator (DEO), Client
- **User Signup** with role selection (except SuperAdmin)
- **Seeded SuperAdmin** for initial full access
- **Edit User** page for SuperAdmin to change roles and assign managers, supervisors, and DEOs dynamically
- Role-based data associations:
  - Supervisors assigned a Manager
  - DEOs assigned a Manager and Supervisor
  - Clients assigned Manager, Supervisor, and DEO

---

## Installation

1. Clone the repository:
    ```bash
    git clone https://github.com/Jugalkishor1/doc_management.git
    cd doc_management
    ```

2. Install dependencies:
    ```bash
    bundle install
    ```

3. Set up the database:
    ```bash
    rails db:create
    rails db:migrate
    rails db:seed
    ```

4. Run the server:
    ```bash
    rails server
    ```

5. Navigate to `http://localhost:3000` in your browser to use the application.

