import { FormsModule, ReactiveFormsModule } from '@angular/forms';

import { CommonModule } from '@angular/common';
import { FlexLayoutModule } from '@angular/flex-layout';
import { MaterialModule } from '../material/material.module';
import { NgModule } from '@angular/core';
import { RegisterComponent } from './register/register.component';
import { RegistrationConfirmComponent } from '../registration-confirm/registration-confirm.component';

@NgModule({
  declarations: [RegisterComponent, RegistrationConfirmComponent],
  imports: [
    CommonModule,
    MaterialModule,
    FlexLayoutModule,
    FormsModule,
    ReactiveFormsModule,
  ],
  exports: [
    RegisterComponent, RegistrationConfirmComponent
  ]
})
export class RegistrationModule { }
