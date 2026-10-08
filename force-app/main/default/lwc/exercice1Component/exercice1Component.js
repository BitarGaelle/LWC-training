import { LightningElement, api } from 'lwc';

export default class Exercice1Component extends LightningElement {

    dep_value = '';
    emp_value = '';

    employees = [
        {
            id: 1,
            name: 'John Smith',
            department: 'IT',
            position: 'Developer'
        },
        {
            id: 2,
            name: 'Sarah Johnson',
            department: 'HR',
            position: 'Recruiter'
        },
        {
            id: 3,
            name: 'Mike Brown',
            department: 'IT',
            position: 'QA Engineer'
        },
        {
            id: 4,
            name: 'Emma Davis',
            department: 'Finance',
            position: 'Accountant'
        },
        {
            id: 5,
            name: 'Chris Wilson',
            department: 'HR',
            position: 'HR Manager'
        }
    ];

    get options() 
    {
        const getAllDep = this.employees.map(item => item.department);

        const setOfDep = [...new Set(getAllDep)];

        const result = setOfDep.map(dep => {
            return {
                label: dep,
                value: dep //i should include it so LWC sees the value selected
            };
        });
        return result;
    }

    get get_employees_dep()
    {
        const getSelectedDep = this.employees.filter(item => item.department === this.dep_value);
        console.log('selectedEmployees',JSON.stringify(getSelectedDep));
        const result = getSelectedDep.map(emp => {
            return {
                label: emp.name,
                emp_value: emp.id
            };
        });
        return result;
    }

    handleChange(event)
    {
        this.dep_value = event.detail.value;
        console.log('this.department.value: ',this.dep_value);
    }

    get_emp_onClick()
    {
        this.emp_value = this.get_employees_dep;

    }

}