require 'csv'

INFECTION_RATE = 0.5
# THRESHOLD = 0.2
SIMULATION_DURATION = 10 # days
POPULATION = 1000

class Person
	attr_accessor :infected, :sick, :infectedPersons

	def initialize
		@infected = 0
		@sick = 0
		@infectedPersons = 0
	end

	def interact(population)
		interaction = rand(population)
	end

	def printInfected
		@infected
	end
end

class Virus
	def transmitVirus(recIndividual)
		recIndividual.infected = rand(2)
	end
end

$population = []
$infectedPopulation = []
$temp = []  # simulates incubation period of 24 hours

# Create Virus that will dominate this simulation

virus = Virus.new

POPULATION.times do
	person = Person.new
	$population << person
end

seed = $population.first
seed.infected = 1
$infectedPopulation << seed
$population.delete(seed)

$time = 1
i = 0

while $time < SIMULATION_DURATION do

	$temp.each do |temp|
		$infectedPopulation << temp
		$temp.delete(temp)
	end

	$infectedPopulation.each do |infectedPerson|
		10.times do 
			target = $population[infectedPerson.interact($population.length)]
			break if target == nil
			if target.infected == 0
				virus.transmitVirus(target)
				if target.infected == 1
					infectedPerson.infectedPersons += 1
					$temp << target
					$population.delete(target)
				end
			end
		end
	end
	$time += 1
end
puts $infectedPopulation.length