SELECT
    SUM(order_product.quantity * unit_cost.unit_material_cost) AS total_material_cost
FROM
    order_
    JOIN order_product ON order_.order_id = order_product.order_id
    CROSS JOIN LATERAL (
        SELECT
            SUM(spec_material.quantity * material.price_per_unit) / specification.product_quantity AS unit_material_cost
        FROM
            specification
            JOIN spec_material ON specification.spec_id = spec_material.spec_id
            JOIN material ON spec_material.material_id = material.material_id
        WHERE
            specification.product_id = order_product.product_id
        GROUP BY
            specification.spec_id
    ) AS unit_cost
WHERE
    order_.order_id = '2';