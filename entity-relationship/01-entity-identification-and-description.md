## Entity Identification and Description

| No. | Entity | Description |
|---:|---|---|
| 1 | **CUSTOMERS** | Users who use Urpet's pet care services. |
| 2 | **PETS** | Pets registered by customers to use pet care services at Urpet. |
| 3 | **SERVICES** | Pet care services provided by Urpet. |
| 4 | **BOOKING_FORM** | Records the process of customers booking services for their pets. |
| 5 | **BOOKING_DETAILS** | Lists the specific services included in each booking. |
| 6 | **EMPLOYEES** | Employees involved in pet care, consultation, or transportation services. |
| 7 | **FEEDBACK** | Records customer reviews and evaluations after using the services. |
| 8 | **PAYMENT** | Manages payment information associated with each service booking. |
| 9 | **PRECHECK** | Records the preliminary health and condition check of a pet before a service is performed. |
| 10 | **PERFORMANCE_DETAIL** | Provides detailed information about the specific services performed during a service session. |
| 11 | **PERFORMANCE** | Records the services that have been performed for a pet. |
| 12 | **INVOICE** | Invoices issued to customers after each service booking, including service charges, taxes, and applicable discounts or deductions. |

## Entity Relationships

| No. | Relationship | Relationship Type | Description |
|---:|---|:---:|---|
| 1 | **CUSTOMERS – PETS** | **1 – N** | A customer can own multiple pets. Each pet belongs to only one customer. |
| 2 | **CUSTOMERS – BOOKING_FORM** | **1 – N** | A customer can create multiple service bookings for their pets. Each booking is associated with only one customer. |
| 3 | **CUSTOMERS – FEEDBACK** | **1 – N** | A customer can submit multiple feedback entries after using the services. Each feedback entry is associated with only one customer. |
| 4 | **BOOKING_FORM – BOOKING_DETAILS** | **1 – N** | A booking can contain multiple booking detail records. Each booking detail record belongs to only one booking. |
| 5 | **SERVICES – BOOKING_DETAILS** | **1 – N** | A service can appear in multiple booking detail records. Each booking detail record is associated with only one specific service. |
| 6 | **BOOKING_FORM – PERFORMANCE** | **1 – 1** | Each booking is associated with only one service performance record. |
| 7 | **PERFORMANCE_DETAIL – PERFORMANCE** | **N – 1** | Each service performance can contain multiple performance detail records. Each performance detail record is associated with exactly one service performance. |
| 8 | **INVOICE – PAYMENT** | **1 – 1** | Each invoice is associated with exactly one payment, and each payment corresponds to exactly one invoice. |
| 9 | **INVOICE – PERFORMANCE** | **1 – N** | An invoice corresponds to a booking and can include multiple service performance records. Conversely, each service performance record can be associated with at most one invoice. |
| 10 | **PRECHECK – PERFORMANCE** | **1 – 1** | Each precheck record leads to one service performance record. Each service performance record is determined based on one precheck record. |
| 11 | **PRECHECK – EMPLOYEE** | **N – N** | A precheck may involve multiple employees. An employee can participate in multiple prechecks. |
| 12 | **PRECHECK – PET** | **N – 1** | Each precheck record applies to only one pet. A pet can undergo multiple health checks, resulting in multiple precheck records. |
