# Business Model & Service Workflow

## 1. Business Model Overview

URPET operates under a **B2C (Business-to-Consumer)** model, providing professional pet care and grooming services directly to pet owners. The service workflow connects customers, pets, employees, service operations, billing, and feedback through a centralized relational database.

---

## 2. Target Customers

URPET primarily targets **dog and cat owners in major urban areas**, especially working professionals and customers with stable incomes who value convenience and professional pet care.

Key customer needs include:

* Professional grooming and pet care services
* Convenient online booking
* Transparent service pricing
* Safe and personalized pet care
* Flexible payment and feedback options

---

## 3. Key Participants

| Participant    | Role                                                             |
| -------------- | ---------------------------------------------------------------- |
| **Customer**   | Registers, books services, makes payments, and provides feedback |
| **Pet**        | Receives grooming and care services                              |
| **Employee**   | Performs prechecks and delivers the requested services           |
| **Management** | Reviews service performance and manages service operations       |
| **Accounting** | Handles invoices and payment records                             |

---

## 4. Customer Service Process

The overall customer journey follows the workflow below:

```text
Customer Registration
        ↓
Service Selection & Pricing
        ↓
Booking
        ↓
Pet Precheck
        ↓
Service Performance
        ↓
Invoice Generation
        ↓
Payment
        ↓
Customer Feedback
```

### Process Overview

1. **Registration** – Customers provide basic information and create an account.
2. **Service Selection** – Customers browse available services and view their prices.
3. **Booking** – Customers select services and provide information about their pet. The system creates a booking record.
4. **Precheck** – Employees inspect the pet's general condition and record relevant observations before service.
5. **Service Performance** – Assigned employees perform the requested services and update the service status and results.
6. **Invoice Generation** – Completed service information is used to prepare the invoice, including applicable discounts.
7. **Payment** – Customers complete payment, and the transaction is recorded for reconciliation and revenue reporting.
8. **Feedback** – Customers can provide feedback on service quality and overall satisfaction.

---

## 5. Pet Care Process

The operational pet care workflow consists of four main stages:

```text
Pet Reception
      ↓
Precheck
      ↓
Basic Grooming
      ↓
Requested Services
      ↓
Final Check & Handover
```

### Process Overview

1. **Reception & Precheck** – Employees verify the booking and assess the pet's general condition, including skin, coat, nails, eyes, ears, and behavior.
2. **Basic Grooming** – The pet receives basic cleaning, drying, and coat care before the requested services.
3. **Requested Services** – Employees perform the services selected by the customer, such as grooming, nail care, ear cleaning, or massage.
4. **Final Check & Handover** – Employees verify the completed services and hand the pet back to the customer or arrange delivery when applicable.

---

## 6. Database Role in the Workflow

The relational database stores and connects information throughout the service lifecycle:

| Business Process    | Database Tables                     |
| ------------------- | ----------------------------------- |
| Customer Management | `CUSTOMERS`                         |
| Pet Management      | `PETS`                              |
| Service Management  | `SERVICES`                          |
| Booking             | `BOOKING_FORM`, `BOOKING_DETAILS`   |
| Pet Precheck        | `PRECHECK`, `PRECHECK_EMPLOYEE`     |
| Service Performance | `PERFORMANCE`, `PERFORMANCE_DETAIL` |
| Billing             | `INVOICE`                           |
| Payment             | `PAYMENT`                           |
| Customer Feedback   | `FEEDBACK`                          |

The database enables URPET to maintain **connected customer, pet, booking, service, operational, and financial records**, supporting daily operations as well as reporting and performance analysis.
