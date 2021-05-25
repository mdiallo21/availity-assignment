//This interface models the type of registration object that holds the state of registration fields
export interface IRegistration {
  firstName: string,
  lastName: string,
  npiNumber: string,
  telephone: number,
  email: string,
  address: string,
  addres2?: string,
  city: string,
  state: string,
  zip: number
}
