CREATE OR REPLACE TABLE `rakamin-kf-analytics-508013.kimia_farma.tabel_analisa` AS
SELECT
  t.transaction_id,
  t.date,
  t.branch_id,
  k.branch_name,
  k.kota,
  k.provinsi,
  k.rating AS rating_cabang,
  t.customer_name,
  t.product_id,
  p.product_name,
  t.price AS actual_price,
  t.discount_percentage,

  CASE
    WHEN t.price <= 50000 THEN 0.10
    WHEN t.price > 50000 AND t.price <= 100000 THEN 0.15
    WHEN t.price > 100000 AND t.price <= 300000 THEN 0.20
    WHEN t.price > 300000 AND t.price <= 500000 THEN 0.25
    WHEN t.price > 500000 THEN 0.30
  END AS persentase_gross_laba,

  -- Nett sales = harga setelah diskon
  t.price * (1 - (t.discount_percentage / 100)) AS nett_sales,

  -- Nett profit = nett sales * persentase gross laba
  (t.price * (1 - (t.discount_percentage / 100))) *
  CASE
    WHEN t.price <= 50000 THEN 0.10
    WHEN t.price > 50000 AND t.price <= 100000 THEN 0.15
    WHEN t.price > 100000 AND t.price <= 300000 THEN 0.20
    WHEN t.price > 300000 AND t.price <= 500000 THEN 0.25
    WHEN t.price > 500000 THEN 0.30
  END AS nett_profit,

  t.rating AS rating_transaksi

FROM `rakamin-kf-analytics-508013.kimia_farma.kf_final_transaction` t
LEFT JOIN `rakamin-kf-analytics-508013.kimia_farma.kf_kantor_cabang` k
  ON t.branch_id = k.branch_id
LEFT JOIN `rakamin-kf-analytics-508013.kimia_farma.kf_product` p
  ON t.product_id = p.product_id;