function calculation() {

  const itemPrice = document.getElementById("item-price")
  const addTaxPrice = document.getElementById("add-tax-price")
  const profit = document.getElementById("profit")

  itemPrice.addEventListener('keyup',function() {
    const fee = Math.floor(itemPrice.value * 0.1)
    addTaxPrice.innerHTML = fee
    const result = itemPrice.value - fee
    profit.innerHTML = result
  })
}

window.addEventListener('load', calculation)
