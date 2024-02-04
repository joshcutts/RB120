class Manufacturer
  attr_reader :products

  def initialize
    @products = ["stent", "guidewire", "closure_device"]
  end

  def work(employees)
    employees.each do |employee|
      employee.manufacturer_work(self)
    end
  end
end

class Scientist
  def manufacturer_work(manufacturer)
    design_clinical_trial(manufacturer.products)
  end

  def design_clinical_trial(products)
    puts "Scientists design a trial and run it for the following products: #{products.join(" and ")}."
  end
end

class ProgramManager
  def manufacturer_work(manufacturer)
    manage_clinical_trial(manufacturer.products)
  end

  def manage_clinical_trial(products)
    puts "Program managers manage timelines and budgets for the following products: #{products.join(" and ")}."
  end
end

class RegulatoryAffairs
  def manufacturer_work(manufacturer)
    liase_with_fda(manufacturer.products)
  end
  
  def liase_with_fda(products)
    puts "Regulatory affairs talks to FDA to inform decisions for the following products: #{products.join(" and ")}."
  end
end

bob = Scientist.new
effie = RegulatoryAffairs.new
kunal = ProgramManager.new
employees = [bob, effie, kunal]
abbott = Manufacturer.new
abbott.work(employees)