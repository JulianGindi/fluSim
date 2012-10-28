require 'csv'

INFECTION_RATE = 0.5
# THRESHOLD = 0.2
SIMULATION_DURATION = 30 # days
POPULATION = 1000;

class Person
	attr_accessor :infected, :sick, :infectedPersons

	def initialize
		@infected = 0
		@sick = 0
		@infectedPersons = 0
	end

	def interact
		interaction = rand(POPULATION) + 1
	end
end

def transmitVirus(recIndividual)
	recIndividual.infected = rand(2)
end

$population = []
$infectedPopulation = []
$temp = []  # simulates incubation period of 24 hours

POPULATION.times do
	person = Person.new
	$population << person
end

seed = $population[0]
seed.infected = 1
$infectedPopulation << seed
$population.delete(seed)

$time = 1
$totalInfect = 0
i = 0

while $time < SIMULATION_DURATION do
	$temp.each do |temp|
		$infectedPopulation << temp
		$temp.delete(temp)
	end
	$infectedPopulation.each do |infectedPerson|
		10.times do 
			target = $population[infectedPerson.interact]
			if target.infected == 0
				transmitVirus(target)
				if target.infected == 1
					infectedPerson.infectedPersons += 1
					$temp << target
					$population.delete(target)
				end
			end
		end
	end
	$time += 1
	$totalInfect += 1
end
