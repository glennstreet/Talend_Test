CREATE OR REPLACE FORCE VIEW OP_STAGE.RUPODM_TFORDERDETAIL_V
(
    "OrderNumber",
    "OrderDetailID",
    "RGHOnRecordAccountNumber",
    "RGHOnRecordName",
    "ProductName",
    "ProductCode",
    "ProductFamily",
    "NumberUnits",
    "UnitType",
    "PublicationTitle",
    "OrderStatus",
    "DistributionFlag",
    "TaxPassThruFlag",
    "PublicationWorkID",
    "OrderSource",
    "CreatedDatetime",
    "CreatedUser",
    "UpdatedDatetime",
    "UpdatedUser",
    "InvoiceNum",
    "AmountTax",
    "RGHPayableAmt",
    "RGHPayDiscAmt",
    "CCCRevAmt",
    "CCCRevDiscAmt",
    "TxnFeeAmt",
    "TxnDiscountAmt",
    "ShippingAmt",
    "TotalAmt",
    "TypeUse"
)
BEQUEATH DEFINER
AS
    SELECT d.ord_inst
               "OrderNumber",
           d.odt_inst
               "OrderDetailID",
           (SELECT account_num
              FROM stg1_ccc_party
             WHERE pty_inst = ror_inst)
               "RGHOnRecordAccountNumber",
           (SELECT orgname
              FROM stg1_ccc_party
             WHERE pty_inst = ror_inst)
               "RGHOnRecordName",
           (SELECT NAME
              FROM stg1_product p
             WHERE p.prd_inst = h.prd_inst)
               "ProductName",
           (SELECT abrv
              FROM stg1_product p
             WHERE p.prd_inst = h.prd_inst)
               "ProductCode",
           (SELECT product_type_dscr
              FROM stg1_product_type pt, stg1_product p
             WHERE pt.ptp_inst = p.ptp_inst AND p.prd_inst = h.prd_inst)
               "ProductFamily",
           NULL
               "NumberUnits",
           NULL
               "UnitType",
           title
               "PublicationTitle",
            odt_status_cd
               "OrderStatus",
           DECODE (evt_inst, NULL, 'N', 'Y')
               "DistributionFlag",
           NULL
               "TaxPassThruFlag",
           idno
               "PublicationWorkID",
           (SELECT brf_dscr
              FROM stg1_general_look_up
             WHERE cd = ord_source_cd AND catg = 'ORDER_SOURCE_CODE')
               "OrderSource",
           d.cre_dtm
               "CreatedDatetime",
           d.cre_user
               "CreatedUser",
           d.upd_dtm
               "UpdatedDatetime",
           d.upd_user
               "UpdatedUser",
           invoice_num
               "InvoiceNum",
           0
               "AmountTax",
           nvl(rpy_transaction_amt,0)
               "RGHPayableAmt",
           0
               "RGHPayDiscAmt",
           nvl(lic_transaction_amt,0)
               "CCCRevAmt",
           0
               "CCCRevDiscAmt",
           nvl(rgh_transaction_amt,0)
               "TxnFeeAmt",
           nvl(disc_transaction_amt,0)
               "TxnDiscountAmt",
           0
               "ShippingAmt",
           nvl(roy_transaction_amt,0)
               "TotalAmt",
           (SELECT brf_dscr
              FROM stg1_type_use tpu
             WHERE tpu.tpu_inst = NVL (d.tpu_inst, 0))
               "TypeUse"
      FROM stg_order_header1  h,
           stg_order_detail2  d
     WHERE     h.ord_inst = d.ord_inst
           AND ord_capture_date >= '01-jan-2015';


GRANT SELECT ON OP_STAGE.RUPODM_TFORDERDETAIL_V TO DW_REPORT;




CREATE OR REPLACE FORCE VIEW OP_STAGE.RUPODM_TFORDERHEADER_V
(
    "OrderNumber",
    "LicenseePartyNumber",
    "OrderDate",
    "OrderChannel",
    "OrganizationName",
    "OrgLocationCountryCode",
    "OrgLocationName",
    "TaxableCity",
    "TaxableRegion",
    "TaxablePostalCode",
    "TaxableCountry",
    "OrderInvoiceUid",
    "OrderSource",
    "CreatedDatetime",
    "CreatedUser",
    "UpdatedDatetime",
    "UpdatedUser",
    TF_PTY_INST
)
BEQUEATH DEFINER
AS
    SELECT ORD_INST
               "OrderNumber",
           (SELECT party_id
              FROM stg1_ccc_party
             WHERE pty_inst = LCN_INST)
               "LicenseePartyNumber",
           Ord_capture_date
               "OrderDate",
           (SELECT abrv
              FROM stg1_product p
             WHERE p.prd_inst = o.prd_inst)
               "OrderChannel",
           (SELECT orgname
              FROM stg1_ccc_party
             WHERE pty_inst = LCN_INST)
               "OrganizationName",
           NULL
               "OrgLocationCountryCode",
           NULL
               "OrgLocationName",
           NULL
               "TaxableCity",
           NULL
               "TaxableRegion",
           NULL
               "TaxablePostalCode",
           NULL
               "TaxableCountry",
           NULL
               "OrderInvoiceUid",
           (SELECT brf_dscr
              FROM stg1_general_look_up
             WHERE cd = ord_source_cd AND catg = 'ORDER_SOURCE_CODE')
               "OrderSource",
           cre_dtm
               "CreatedDatetime",
           cre_user
               "CreatedUser",
           upd_dtm
               "UpdatedDatetime",
           upd_user
               "UpdatedUser",
           lcn_inst
               tf_pty_inst
      FROM stg_order_header1 o
     WHERE ord_capture_date >= '01-jan-2015'                 --and rownum < 2
;


GRANT SELECT ON OP_STAGE.RUPODM_TFORDERHEADER_V TO DW_REPORT;




CREATE OR REPLACE FORCE VIEW OP_STAGE.RUP_TFINVOICES_V
(
    INVOICE_NO,
    "InvSourceSystem",
    "InvDate",
    "InvStatus",
    "PaymentDate",
    "InvoiceTotalAmount",
    "InvoiceTaxAmt",
    "InvoiceDiscountAmt",
    "InvoiceExchangeRate",
    "Currency",
    "OrganizationName",
    "TotalTxnCurrency",
    "OriginTxnCurrency",
    "TaxAmtTxnCurrency",
    "PaymentStatus",
    "InvoiceClass",
    "OrganizationUid",
    "CreatedDate",
    "CreatedBy",
    "UpdatedDate",
    "UpdatedBy"
)
BEQUEATH DEFINER
AS
    SELECT invoice_no,
           'TF'
               "InvSourceSystem",
           invoice_date
               "InvDate",
           DECODE (paid_in_full_flag,
                   'Y', 'PAID',
                   DECODE (invoice_pct_paid, 0, 'NOTPAID', 'PARTIALLYPAID'))
               "InvStatus",
           date_paid
               "PaymentDate",
           total_amount
               "InvoiceTotalAmount",
           0
               "InvoiceTaxAmt",
           0
               "InvoiceDiscountAmt",
           0
               "InvoiceExchangeRate",
           NULL
               "Currency",
           orgname
               "OrganizationName",
           total_amount
               "TotalTxnCurrency",
           total_amount
               "OriginTxnCurrency",
           0
               "TaxAmtTxnCurrency",
           DECODE (paid_in_full_flag,
                   'Y', 'Paid',
                   DECODE (invoice_pct_paid, 0, 'NotPaid', 'PartiallyPaid'))
               "PaymentStatus",
           DECODE (invoice_adjustment_type, 'I', 'INVOICE', 'ADJUSTMENT')
               "InvoiceClass",
           p.pty_inst
               "OrganizationUid",
           date_created
               "CreatedDate",
           NULL
               "CreatedBy",
           date_last_modified
               "UpdatedDate",
           last_maintained_by
               "UpdatedBy"
      FROM ar_invoice_sdm ar, stg1_ccc_party p
     WHERE     account_num = customer_id
           AND person_org_type = 'O'
           AND invoice_no NOT IN ('NONE', 'INVALID')
           AND date_paid >= '01-jan-2015';


GRANT SELECT ON OP_STAGE.RUP_TFINVOICES_V TO DW_REPORT;





CREATE OR REPLACE FORCE VIEW OP_STAGE.RUP_TFLICENSEES_V
(
    "LicenseeName",
    "ContactEmail",
    "LicSubType",
    "ParentOrgUid",
    "LicenseePartyNumb",
    "TaxCountry",
    "NotForProfit",
    TF_PTY_INST
)
BEQUEATH DEFINER
AS
    SELECT party_name                         "LicenseeName",
           internet_login                     "ContactEmail",
           (SELECT DECODE (person_org_type, 'O', 'COMPANY', 'PERSON')
              FROM stg1_ccc_party sp
             WHERE pty_inst = tf_pty_inst)    "LicSubType",
           NULL                               "ParentOrgUid",
           party_number                       "LicenseePartyNumb",
           NULL                               "TaxCountry",
           NULL                               "NotForProfit",
           tf_pty_inst
      FROM licensees_sdm_1_2 l
     WHERE     dimension_key IN (SELECT UNIQUE lic_pk_key
                                   FROM order_detail_sf
                                  WHERE tim_pk_Key > 20150000)
           AND party_name != 'ZZNA';


GRANT SELECT ON OP_STAGE.RUP_TFLICENSEES_V TO DW_REPORT;
