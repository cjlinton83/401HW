      program P1
            do
                  call display_menu
                  call io_handler
            end do
      end program P1

      subroutine display_menu
            print *,
            print *,
            print *, 'Enter a conversion option (1-6, or 0 to exit):'
            print *, '-------------------------'
            print *, '(1) Pounds to Kilograms'
            print *, '(2) Kilograms to Pounds'
            print *, '(3) Feet to Meters'
            print *, '(4) Meters to Feet'
            print *, '(5) Fahrenheit to Celsius'
            print *, '(6) Celsius to Fahrenheit'
            print *, '(0) Exit this program'
            print *, '-------------------------'
      end subroutine display_menu

      subroutine io_handler
            implicit none
            integer :: n
            real    :: v
            real, parameter :: lb_per_kg = 2.20462
            real, parameter :: ft_per_m  = 3.28084

            read *, n

            select case(n)
            case(0)
                  stop
            case(1)
                  call prompt_for_conversion_value(v)
                  print *, 'Pounds:', v, 'Kilograms:', v/lb_per_kg
            case(2)
                  call prompt_for_conversion_value(v)
                  print *, 'Kilograms:', v, 'Pounds:', v*lb_per_kg
            case(3)
                  call prompt_for_conversion_value(v)
                  print *, 'Feet:', v, 'Meters:', v/ft_per_m
            case(4)
                  call prompt_for_conversion_value(v)
                  print *, 'Meters:', v, 'Feet:', v*ft_per_m
            case(5)
                  call prompt_for_conversion_value(v)
                  print *, 'Fahrenheit:', v, 'Celsius:', (v-32)*5/9
            case(6)
                  call prompt_for_conversion_value(v)
                  print *, 'Celsius:', v, 'Fahrenheit:', v*9/5+32
            end select
      end subroutine io_handler

      subroutine prompt_for_conversion_value(v)
            implicit none
            real :: v

            print *, 'Enter a value to convert:'
            read *, v
      end subroutine prompt_for_conversion_value