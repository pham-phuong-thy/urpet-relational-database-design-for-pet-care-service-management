## Entity Model Design

### 1. CUSTOMERS

| Attribute       | Description                    | Data Type        | Key Type | Data Length | Function                                                        | Status   |
| --------------- | ------------------------------ | ---------------- | -------- | ----------- | --------------------------------------------------------------- | -------- |
| CustomerID      | Customer identification number | INT              | PK       | —           | Uniquely identifies each customer                               | Required |
| CustomerName    | Customer's full name           | NVARCHAR         | —        | 255         | Displays the customer's name in transactions                    | Required |
| CustomerDOB     | Customer's date of birth       | DATE             | —        | —           | Supports age analysis and birthday-related services             | Optional |
| CustomerEmail   | Customer's email address       | NVARCHAR         | —        | 255         | Used to send confirmations, promotions, and other notifications | Required |
| CustomerPhone   | Customer's phone number        | NVARCHAR         | —        | 50          | Used for appointment confirmation and customer service          | Required |
| CustomerAddress | Customer's address             | NTEXT / NVARCHAR | —        | Unlimited   | Used to identify the service area and send relevant information | Required |

---

### 2. PETS

| Attribute   | Description                    | Data Type | Key Type | Data Length | Function                                                    | Status   |
| ----------- | ------------------------------ | --------- | -------- | ----------- | ----------------------------------------------------------- | -------- |
| PetID       | Pet identification number      | INT       | PK       | —           | Uniquely identifies each pet                                | Required |
| CustomerID  | Customer identification number | INT       | FK       | —           | Links the pet to its owner in the CUSTOMERS table           | Required |
| Species     | Pet species                    | NVARCHAR  | —        | 50          | Classifies pets for appropriate care services               | Required |
| Weight      | Pet's weight                   | FLOAT     | —        | —           | Used for health monitoring and service provision            | Required |
| PetDOB      | Pet's date of birth            | DATE      | —        | —           | Supports age estimation and vaccination scheduling          | Required |
| MedicalNote | Pet's medical notes            | NTEXT     | —        | Unlimited   | Records special health conditions or medical considerations | Optional |

---

### 3. EMPLOYEES

| Attribute     | Description                    | Data Type | Key Type | Data Length | Function                                                          | Status   |
| ------------- | ------------------------------ | --------- | -------- | ----------- | ----------------------------------------------------------------- | -------- |
| EmployeeID    | Employee identification number | INT       | PK       | —           | Uniquely identifies each employee                                 | Required |
| EmployeeName  | Employee's name                | NVARCHAR  | —        | 255         | Displays the employee's name in the interface and service records | Required |
| EmployeeDOB   | Employee's date of birth       | DATE      | —        | —           | Supports age and insurance-related management                     | Optional |
| EmployeeEmail | Employee's email address       | NVARCHAR  | —        | 255         | Used to send work-related information and schedules               | Required |
| EmployeePhone | Employee's phone number        | NVARCHAR  | —        | 50          | Used for calls and messages during work shifts                    | Required |
| Position      | Employee's job position        | NVARCHAR  | —        | 255         | Supports task assignment and role-based access                    | Required |

---

### 4. SERVICES

| Attribute    | Description                             | Data Type | Key Type | Data Length | Function                                                    | Status   |
| ------------ | --------------------------------------- | --------- | -------- | ----------- | ----------------------------------------------------------- | -------- |
| ServiceID    | Service identification number           | INT       | PK       | —           | Uniquely identifies each service                            | Required |
| Category     | Service category                        | NVARCHAR  | —        | 255         | Groups services for display and filtering                   | Required |
| Description  | Detailed service description            | NTEXT     | —        | Unlimited   | Provides customers with clear information about the service | Optional |
| Price        | Service price                           | DECIMAL   | —        | —           | Used to calculate service charges during booking            | Required |
| TargetAnimal | Animal species eligible for the service | NVARCHAR  | —        | 255         | Helps filter services by animal species                     | Required |

---

### 5. BOOKING_FORM

| Attribute           | Description                                | Data Type | Key Type | Data Length | Function                                            | Status   |
| ------------------- | ------------------------------------------ | --------- | -------- | ----------- | --------------------------------------------------- | -------- |
| BookingID           | Booking identification number              | INT       | PK       | —           | Uniquely identifies each booking                    | Required |
| CustomerID          | Customer identification number             | INT       | FK       | —           | Links the booking to the customer                   | Required |
| PetID               | Pet identification number                  | INT       | FK       | —           | Links the booking to the pet receiving the service  | Required |
| BookingDate         | Date when the customer created the booking | DATE      | —        | —           | Tracks booking history                              | Required |
| AppointmentDateTime | Scheduled service date and time            | DATETIME  | —        | —           | Supports staff scheduling and appointment reminders | Required |

---

### 6. FEEDBACK

| Attribute    | Description                          | Data Type | Key Type | Data Length | Function                                            | Status   |
| ------------ | ------------------------------------ | --------- | -------- | ----------- | --------------------------------------------------- | -------- |
| FeedbackID   | Feedback identification number       | INT       | PK       | —           | Uniquely identifies each feedback entry             | Required |
| CustomerID   | Customer identification number       | INT       | FK       | —           | Links the feedback to the customer who submitted it | Required |
| Comment      | Feedback content                     | NTEXT     | —        | Unlimited   | Stores the customer's review or comments            | Optional |
| FeedbackDate | Date when the feedback was submitted | DATE      | —        | —           | Records when the customer submitted the feedback    | Required |

---

### 7. PAYMENT

| Attribute       | Description                   | Data Type | Key Type | Data Length | Function                                                                | Status   |
| --------------- | ----------------------------- | --------- | -------- | ----------- | ----------------------------------------------------------------------- | -------- |
| PaymentID       | Payment identification number | INT       | PK       | —           | Uniquely identifies each payment transaction                            | Required |
| InvoiceID       | Invoice identification number | INT       | FK       | —           | Links the payment to the corresponding invoice                          | Required |
| PaymentDateTime | Payment date and time         | DATETIME  | —        | —           | Records when the customer made the payment                              | Required |
| Amount          | Payment amount                | MONEY     | —        | —           | Records the amount paid by the customer                                 | Required |
| Bill            | Payment receipt               | IMAGE     | —        | —           | Stores an image of the payment receipt or a reference to the image file | Required |

---

### 8. BOOKING_DETAILS

| Attribute     | Description                                         | Data Type | Key Type | Data Length | Function                                                                                                          | Status   |
| ------------- | --------------------------------------------------- | --------- | -------- | ----------- | ----------------------------------------------------------------------------------------------------------------- | -------- |
| BookingID     | Booking identification number                       | INT       | PK, FK   | —           | Composite key component identifying the booking                                                                   | Required |
| ServiceID     | Service identification number                       | INT       | PK, FK   | —           | Composite key component identifying the specific service in the booking                                           | Required |
| ServiceStatus | Service status                                      | VARCHAR   | —        | 255         | Tracks the progress of each service within the booking                                                            | Required |
| ServicePrice  | Service unit price                                  | DECIMAL   | —        | —           | Stores the service price at the time of booking rather than dynamically referencing the current price in SERVICES | Required |
| Quantity      | Service quantity                                    | INT       | —        | —           | Records the quantity of the service ordered                                                                       | Required |
| Discount      | Discount amount                                     | DECIMAL   | —        | —           | Records the discount applied to the specific service in the booking                                               | Optional |
| TotalAmount   | Total amount = (ServicePrice × Quantity) − Discount | DECIMAL   | —        | —           | Records the total amount payable for the service after discount                                                   | Required |
| PromotionID   | Promotion identification number                     | INT       | —        | —           | References the applicable promotion for tracking purposes                                                         | Optional |

---

### 9. PRECHECK

| Attribute        | Description                                                      | Data Type | Key Type | Data Length | Function                                                       | Status   |
| ---------------- | ---------------------------------------------------------------- | --------- | -------- | ----------- | -------------------------------------------------------------- | -------- |
| PrecheckID       | Precheck identification number                                   | INT       | PK       | —           | Uniquely identifies each pre-service check                     | Required |
| PetID            | Pet identification number                                        | INT       | FK       | —           | Links the precheck to the pet being examined                   | Required |
| GeneralCondition | Pet's general condition, e.g., healthy or anxious                | NVARCHAR  | —        | 255         | Records the overall condition observed during the precheck     | Required |
| SkinCondition    | Notes on skin, coat, parasites, etc.                             | TEXT      | —        | Unlimited   | Provides information relevant to bathing and grooming services | Optional |
| BehaviorNotes    | Notes on pet behavior, e.g., biting, fear of water, or agitation | TEXT      | —        | Unlimited   | Alerts employees to behavioral considerations during service   | Optional |
| CreatedAt        | Date and time when the precheck record was created               | DATETIME  | —        | —           | Records the time of the precheck                               | Required |

---

### 10. PERFORMANCE

| Attribute     | Description                                           | Data Type | Key Type | Data Length | Function                                                | Status   |
| ------------- | ----------------------------------------------------- | --------- | -------- | ----------- | ------------------------------------------------------- | -------- |
| PerformanceID | Service performance identification number             | INT       | PK       | —           | Uniquely identifies each service performance record     | Required |
| StartTime     | Service start time                                    | DATETIME  | —        | —           | Records when the service started                        | Required |
| EndTime       | Service end time                                      | DATETIME  | —        | —           | Records when the service was completed                  | Required |
| CreatedAt     | Date and time when the performance record was created | DATETIME  | —        | —           | Records when the service performance record was created | Required |

---

### 11. PERFORMANCE_DETAIL

| Attribute     | Description                                                           | Data Type | Key Type | Data Length | Function                                                                                               | Status   |
| ------------- | --------------------------------------------------------------------- | --------- | -------- | ----------- | ------------------------------------------------------------------------------------------------------ | -------- |
| PerformanceID | Service performance identification number                             | INT       | PK, FK   | —           | Identifies the corresponding service performance record                                                | Required |
| InvoiceID     | Invoice identification number                                         | INT       | PK, FK   | —           | Combined with PerformanceID as a composite key when a performance record contains multiple detail rows | Required |
| Status        | Service execution status: Pending, In Progress, Completed, or Skipped | VARCHAR   | —        | 50          | Indicates the completion status of each service item                                                   | Required |
| Result        | Service result, e.g., completed successfully or not completed         | NVARCHAR  | —        | 255         | Provides a brief summary of the result of each service item                                            | Optional |
| Notes         | Additional notes regarding abnormalities or special requirements      | TEXT      | —        | Unlimited   | Allows employees to record observations or specific difficulties                                       | Optional |

---

### 12. INVOICE

| Attribute   | Description                                          | Data Type | Key Type | Data Length | Function                                                                                            | Status   |
| ----------- | ---------------------------------------------------- | --------- | -------- | ----------- | --------------------------------------------------------------------------------------------------- | -------- |
| InvoiceID   | Invoice identification number                        | INT       | PK       | —           | Uniquely identifies each invoice                                                                    | Required |
| InvoiceDate | Invoice issuance date                                | DATETIME  | —        | —           | Records when the invoice was issued                                                                 | Required |
| Amount      | Amount before tax and other adjustments              | DECIMAL   | —        | —           | Records the amount to be charged                                                                    | Required |
| TaxAmount   | Value-added tax (VAT) amount                         | DECIMAL   | —        | —           | Records the applicable VAT amount                                                                   | Optional |
| TotalAmount | Total invoice amount                                 | DECIMAL   | —        | —           | Stores the final amount at the time the invoice is issued, ensuring data integrity and traceability | Required |
| Status      | Invoice status, e.g., Issued, Cancelled, or Adjusted | VARCHAR   | —        | 255         | Tracks the current status of the invoice                                                            | Required |
| CreatedAt   | Date and time when the invoice record was created    | DATETIME  | —        | —           | Records when the invoice record was created                                                         | Required |

---

### 13. PRECHECK_EMPLOYEE

| Attribute  | Description                         | Data Type | Key Type | Data Length | Function                                                   | Status   |
| ---------- | ----------------------------------- | --------- | -------- | ----------- | ---------------------------------------------------------- | -------- |
| EmployeeID | Employee identification number      | INT       | PK, FK   | —           | Identifies the employee participating in the precheck      | Required |
| PrecheckID | Precheck identification number      | INT       | PK, FK   | —           | Identifies the precheck in which the employee participates | Required |
| Role       | Employee's role during the precheck | VARCHAR   | —        | 255         | Specifies the employee's role in the examination process   | Required |
| CheckTime  | Date and time of the check          | DATETIME  | —        | —           | Records when the employee performed the check              | Optional |
