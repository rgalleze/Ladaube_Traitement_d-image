################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
S_UPPER_SRCS += \
../conversion2_C.S 

OBJS += \
./conversion2_C.o 


# Each subdirectory must supply rules for building sources it contributes
%.o: ../%.S
	@echo 'Building file: $<'
	@echo 'Invoking: GCC Assembler'
	as -g -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


