package com.sgrh.security.conf;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.User.UserBuilder;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.factory.PasswordEncoderFactories;
import org.springframework.security.crypto.password.NoOpPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

@Configuration
@EnableWebSecurity
public class SecurityConfiguration extends WebSecurityConfigurerAdapter {
	
	@Autowired
	private UserDetailsService userDetailsService;
	
	 
	@Bean
	public BCryptPasswordEncoder passwordEncoder() {
	  return new BCryptPasswordEncoder();
	};
	

	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		//auth.userDetailsService(userDetailsService);
		@SuppressWarnings("deprecation")
		UserBuilder users = User.withDefaultPasswordEncoder();
		
			auth.inMemoryAuthentication()
				.withUser(users.username("john").password("123").roles("EMPLOYEE"))
				.withUser(users.username("mary").password("123").roles("MANAGER"))
				.withUser(users.username("susan").password("123").roles("ADMIN"));
	}

	/*@Override
	protected void configure(HttpSecurity http) throws Exception {
		http.authorizeRequests().anyRequest().authenticated()
		.and()
		.formLogin().loginPage("/login")
		.loginProcessingUrl("/authenticateTheUser").permitAll().and().logout()
		.permitAll();
		/*http.authorizeRequests()
		.antMatchers("/WEB-INF/jsps/**").permitAll().anyRequest().authenticated()//.hasRole("EMPLOYEE")
		//.antMatchers("/report/**").hasRole("SUPERUSER")
		//.antMatchers("/input/**").hasRole("ADMIN")
		.and()
		.formLogin().loginPage("/login")
		.loginProcessingUrl("/authenticateTheUser").permitAll().and().logout()
		.permitAll()
		.and().exceptionHandling().accessDeniedPage("/access_denied")
		.and().csrf().disable();
	}*/

}
