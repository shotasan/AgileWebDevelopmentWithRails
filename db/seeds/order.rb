20.times do |i|
  Order.create(name: "Customer#{i}",
               address: "#{i} Main Street",
               email: "customer-#{i}@example.com",
               pay_type: "現金"
  )
end