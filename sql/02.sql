# URPET SQL Queries

## 1. Total Revenue by Day

```sql
SELECT
    CAST(InvoiceDate AS DATE) AS RevenueDate,
    COUNT(InvoiceID) AS NumberOfInvoices,
    SUM(TotalAmount) AS TotalRevenue
FROM INVOICE
GROUP BY CAST(InvoiceDate AS DATE)
ORDER BY RevenueDate;
```

## 2. Revenue by Service Type

```sql
SELECT
    S.ServiceID,
    S.Category AS ServiceType,
    COUNT(BD.ServiceID) AS NumberOfServicesPerformed,
    SUM(BD.Total_Amount) AS TotalRevenue
FROM BOOKING_DETAILS BD
JOIN SERVICES S
    ON BD.ServiceID = S.ServiceID
GROUP BY
    S.ServiceID,
    S.Category
ORDER BY TotalRevenue DESC;
```

## 3. Service Type with the Highest Revenue

```sql
SELECT TOP 1
    S.ServiceID,
    S.Category AS ServiceType,
    SUM(BD.Total_Amount) AS TotalRevenue
FROM BOOKING_DETAILS BD
JOIN SERVICES S
    ON BD.ServiceID = S.ServiceID
GROUP BY
    S.ServiceID,
    S.Category
ORDER BY TotalRevenue DESC;
```

## 4. Bookings with Payments of at Least 2 Million VND in May 2025

```sql
SELECT
    PY.PaymentID,
    PY.PaymentDateTime,
    I.InvoiceID,
    C.CustomerName,
    PY.Amount
FROM PAYMENT PY
JOIN INVOICE I
    ON PY.InvoiceID = I.InvoiceID
JOIN PERFORMANCE_DETAIL PD
    ON PD.InvoiceID = I.InvoiceID
JOIN PERFORMANCE P
    ON PD.PerformanceID = P.PerformanceID
JOIN BOOKING_FORM BF
    ON P.PerformanceID = BF.BookingID
JOIN CUSTOMERS C
    ON BF.CustomerID = C.CustomerID
WHERE
    MONTH(PY.PaymentDateTime) = 5
    AND YEAR(PY.PaymentDateTime) = 2025
    AND PY.Amount >= 2000000;
```

## 5. Revenue Before and After Discounts

```sql
SELECT
    BD.ServiceID,
    SUM(BD.ServicePrice * BD.Quantity) AS OriginalRevenue,
    SUM(BD.Discount) AS TotalDiscount,
    SUM(BD.Total_Amount) AS FinalRevenue
FROM BOOKING_DETAILS BD
GROUP BY BD.ServiceID;
```

## 6. All Booking Information with Customer Details

```sql
SELECT
    BF.BookingID,
    C.CustomerName,
    C.CustomerPhone,
    BF.BookingDate,
    BF.AppointmentDateTime
FROM BOOKING_FORM BF
JOIN CUSTOMERS C
    ON BF.CustomerID = C.CustomerID;
```

## 7. Average Service Duration by Service Type

```sql
SELECT
    S.Category AS ServiceType,
    AVG(DATEDIFF(MINUTE, P.StartTime, P.EndTime)) AS AvgDurationMinutes
FROM PERFORMANCE P
JOIN BOOKING_FORM BF
    ON P.PerformanceID = BF.BookingID
JOIN BOOKING_DETAILS BD
    ON BF.BookingID = BD.BookingID
JOIN SERVICES S
    ON BD.ServiceID = S.ServiceID
GROUP BY S.Category;
```

## 8. Daily Service Completion Rate

```sql
SELECT
    CAST(BF.AppointmentDateTime AS DATE) AS BookingDate,
    COUNT(BF.BookingID) AS TotalBookings,
    SUM(
        CASE
            WHEN PD.Status = 'Completed' THEN 1
            ELSE 0
        END
    ) AS CompletedCount,
    SUM(
        CASE
            WHEN PD.Status = 'Completed' THEN 1
            ELSE 0
        END
    ) * 100.0 / COUNT(BF.BookingID) AS CompletionRate
FROM BOOKING_FORM BF
LEFT JOIN BOOKING_DETAILS BD
    ON BF.BookingID = BD.BookingID
LEFT JOIN PERFORMANCE P
    ON P.PerformanceID IN (
        SELECT PD2.PerformanceID
        FROM PERFORMANCE_DETAIL PD2
    )
LEFT JOIN PERFORMANCE_DETAIL PD
    ON P.PerformanceID = PD.PerformanceID
GROUP BY CAST(BF.AppointmentDateTime AS DATE)
ORDER BY BookingDate;
```

## 9. Discounted Bookings with Good Service Performance

```sql
SELECT
    BF.BookingID,
    C.CustomerName,
    S.Category AS ServiceType,
    BD.PromotionID,
    BD.Discount,
    BD.Total_Amount AS RevenueAfterDiscount,
    DATEDIFF(MINUTE, PR.CreatedAt, P.StartTime) AS WaitingTimeAfterPrecheck,
    DATEDIFF(MINUTE, P.StartTime, P.EndTime) AS ServiceDurationMinutes,
    I.TotalAmount AS InvoiceTotal,
    CASE
        WHEN DATEDIFF(MINUTE, P.StartTime, P.EndTime) BETWEEN 15 AND 45
             AND DATEDIFF(MINUTE, PR.CreatedAt, P.StartTime) <= 180
        THEN N'Good Performance'
        ELSE N'Requires Review'
    END AS PerformanceEvaluation
FROM BOOKING_FORM BF
JOIN CUSTOMERS C
    ON BF.CustomerID = C.CustomerID
JOIN BOOKING_DETAILS BD
    ON BF.BookingID = BD.BookingID
JOIN SERVICES S
    ON BD.ServiceID = S.ServiceID
JOIN PETS PT
    ON BF.PetID = PT.PetID
JOIN PRECHECK PR
    ON PR.PetID = PT.PetID
JOIN PERFORMANCE P
    ON BF.BookingID = P.PerformanceID
JOIN PERFORMANCE_DETAIL PD
    ON P.PerformanceID = PD.PerformanceID
JOIN INVOICE I
    ON PD.InvoiceID = I.InvoiceID
WHERE
    BD.PromotionID IS NOT NULL
    AND BD.Discount > 0
    AND I.Status = N'Đã thanh toán'
ORDER BY RevenueAfterDiscount DESC;
```

## 10. Employee Performance Based on Number of Processed Bookings

```sql
SELECT
    E.EmployeeID,
    E.EmployeeName,
    COUNT(DISTINCT BF.BookingID) AS NumberOfServicesCompleted
FROM EMPLOYEES E
JOIN PRECHECK_EMPLOYEE PE
    ON E.EmployeeID = PE.EmployeeID
JOIN PRECHECK PR
    ON PE.PrecheckID = PR.PrecheckID
JOIN PETS PT
    ON PR.PetID = PT.PetID
JOIN BOOKING_FORM BF
    ON PT.PetID = BF.PetID
GROUP BY
    E.EmployeeID,
    E.EmployeeName
ORDER BY NumberOfServicesCompleted DESC;
```

## 11. Best-Performing Employee in June 2025 Based on Number of Services Performed

```sql
SELECT
    E.EmployeeID,
    E.EmployeeName,
    COUNT(BD.BookingID) AS NumberOfServicesPerformed,
    SUM(BD.Total_Amount) AS TotalRevenueGenerated
FROM EMPLOYEES E
JOIN PRECHECK_EMPLOYEE PE
    ON E.EmployeeID = PE.EmployeeID
JOIN PRECHECK PR
    ON PE.PrecheckID = PR.PrecheckID
JOIN PETS PT
    ON PR.PetID = PT.PetID
JOIN BOOKING_FORM BF
    ON PT.PetID = BF.PetID
JOIN BOOKING_DETAILS BD
    ON BF.BookingID = BD.BookingID
JOIN PERFORMANCE P
    ON BF.BookingID = P.PerformanceID
JOIN PERFORMANCE_DETAIL PD
    ON P.PerformanceID = PD.PerformanceID
JOIN INVOICE I
    ON PD.InvoiceID = I.InvoiceID
WHERE
    MONTH(BF.BookingDate) = 6
    AND YEAR(BF.BookingDate) = 2025
GROUP BY
    E.EmployeeID,
    E.EmployeeName
ORDER BY TotalRevenueGenerated DESC;
```

## 12. Service Receiving the Most Negative Feedback

```sql
SELECT
    S.ServiceID,
    S.Category AS ServiceType,
    COUNT(*) AS NumberOfNegativeFeedback
FROM FEEDBACK F
JOIN CUSTOMERS C
    ON F.CustomerID = C.CustomerID
JOIN BOOKING_FORM BF
    ON C.CustomerID = BF.CustomerID
JOIN BOOKING_DETAILS BD
    ON BF.BookingID = BD.BookingID
JOIN SERVICES S
    ON BD.ServiceID = S.ServiceID
WHERE
    F.Comment IS NOT NULL
    AND (
        F.Comment LIKE N'%tệ%'
        OR F.Comment LIKE N'%quá tệ%'
        OR F.Comment LIKE N'%không hài lòng%'
        OR F.Comment LIKE N'%thất vọng%'
        OR F.Comment LIKE N'%rất thất vọng%'
    )
GROUP BY
    S.ServiceID,
    S.Category
ORDER BY NumberOfNegativeFeedback DESC;
```

## 13. Unpaid and Cancelled Invoices

```sql
SELECT
    COUNT(*) AS TotalInvoices,
    SUM(
        CASE
            WHEN I.Status = 'Chưa thanh toán' THEN 1
            ELSE 0
        END
    ) AS UnpaidInvoices,
    SUM(
        CASE
            WHEN I.Status = 'Hủy' THEN 1
            ELSE 0
        END
    ) AS CancelledInvoices,
    ROUND(
        SUM(
            CASE
                WHEN I.Status = 'Chưa thanh toán' THEN 1
                ELSE 0
            END
        ) * 1.0 / COUNT(*),
        2
    ) AS UnpaidRate,
    ROUND(
        SUM(
            CASE
                WHEN I.Status = 'Hủy' THEN 1
                ELSE 0
            END
        ) * 1.0 / COUNT(*),
        2
    ) AS CancellationRate
FROM INVOICE I;
```

## 14. Services and Number of Bookings by Day of the Week

```sql
SELECT
    DATENAME(WEEKDAY, BF.BookingDate) AS DayOfWeek,
    S.Category AS ServiceType,
    COUNT(*) AS NumberOfBookings
FROM BOOKING_FORM BF
JOIN BOOKING_DETAILS BD
    ON BF.BookingID = BD.BookingID
JOIN SERVICES S
    ON BD.ServiceID = S.ServiceID
GROUP BY
    DATENAME(WEEKDAY, BF.BookingDate),
    S.Category
ORDER BY
    DayOfWeek,
    NumberOfBookings DESC;
```

## 15. Customers with at Least Five Bookings

```sql
SELECT
    C.CustomerID,
    C.CustomerName,
    COUNT(BF.BookingID) AS NumberOfBookings
FROM BOOKING_FORM BF
JOIN CUSTOMERS C
    ON BF.CustomerID = C.CustomerID
GROUP BY
    C.CustomerID,
    C.CustomerName
HAVING COUNT(BF.BookingID) >= 5
ORDER BY NumberOfBookings DESC;
```

## 16. Customers Who Used the Most Different Service Types

```sql
SELECT
    C.CustomerID,
    C.CustomerName,
    COUNT(DISTINCT S.Category) AS NumberOfServiceTypesUsed
FROM CUSTOMERS C
JOIN BOOKING_FORM BF
    ON C.CustomerID = BF.CustomerID
JOIN BOOKING_DETAILS BD
    ON BF.BookingID = BD.BookingID
JOIN SERVICES S
    ON BD.ServiceID = S.ServiceID
GROUP BY
    C.CustomerID,
    C.CustomerName
ORDER BY NumberOfServiceTypesUsed DESC;
```

