import { DataSource } from 'typeorm';
import { Department } from './src/database/entities/department.entity';
import { Municipality } from './src/database/entities/municipality.entity';

const departmentsData = [
  {
    name: 'Sucre',
    municipalities: [
      'Sincé',
      'Ovejas',
      'Colosó',
      'Coveñas',
      'Betulia',
      'El Roble',
      'Galeras',
      'La Unión',
      'Los Palmitos',
      'Morroa',
      'Sampués',
      'San Benito Abad',
      'San Juan Benavides',
      'San Marcos',
      'San Onofre',
      'Santiago de Tolú',
      'Tolú Viejo'
    ]
  },
  {
    name: 'Córdoba',
    municipalities: [
      'Montería',
      'Cereté',
      'Lorica',
      'Chinú',
      'San Pelayo',
      'Moñitos',
      'Tierralta',
      'Valencia',
      'Planeta Rica',
      'Ciénaga de Oro',
      'Sahagún',
      'Cotorra',
      'Canalete',
      'La Apartada',
      'San Andrés de Sotavento',
      'Purísima de la Concepción',
      'Pueblo Nuevo',
      'Arboletes',
      'Tuchín',
      'Ayapel',
      'Buenavista'
    ]
  }
];

async function seedDepartmentsAndMunicipalities() {
  const AppDataSource = new DataSource({
    type: 'postgres',
    host: process.env.DB_HOST || 'localhost',
    port: parseInt(process.env.DB_PORT || '5236'),
    username: process.env.DB_USERNAME || 'temp-smartpol_user',
    password: process.env.DB_PASSWORD || 'temp-smartpol_password',
    database: process.env.DB_DATABASE || 'temp-smartpol_db',
    entities: ['src/database/entities/*.entity.ts'],
    synchronize: false,
  });

  try {
    await AppDataSource.initialize();
    console.log('✓ Database connected\n');

    const departmentRepository = AppDataSource.getRepository(Department);
    const municipalityRepository = AppDataSource.getRepository(Municipality);

    let departmentsCreated = 0;
    let municipalitiesCreated = 0;
    let departmentsSkipped = 0;
    let municipalitiesSkipped = 0;

    console.log('Seeding departments and municipalities...\n');

    for (const deptData of departmentsData) {
      // Check if department already exists
      const existingDept = await departmentRepository.findOne({
        where: { name: deptData.name },
      });

      let department: Department;

      if (existingDept) {
        console.log(`⚠ Department "${deptData.name}" already exists. Skipping...`);
        departmentsSkipped++;
        department = existingDept;
      } else {
        const newDept = departmentRepository.create({ name: deptData.name });
        department = await departmentRepository.save(newDept);
        console.log(`✓ Created department: ${deptData.name}`);
        departmentsCreated++;
      }

      // Add municipalities to the department
      console.log(`\n  Adding municipalities to ${deptData.name}:`);
      for (const municipalityName of deptData.municipalities) {
        const existingMuni = await municipalityRepository.findOne({
          where: {
            name: municipalityName,
            department: { id: department.id }
          },
          relations: ['department']
        });

        if (existingMuni) {
          console.log(`    ⚠ Municipality "${municipalityName}" already exists. Skipping...`);
          municipalitiesSkipped++;
        } else {
          const newMuni = municipalityRepository.create({
            name: municipalityName,
            department: department
          });
          await municipalityRepository.save(newMuni);
          console.log(`    ✓ Created municipality: ${municipalityName}`);
          municipalitiesCreated++;
        }
      }
      console.log();
    }

    console.log(`\n✅ Seeding completed!`);
    console.log(`   • Departments created: ${departmentsCreated}`);
    console.log(`   • Departments skipped: ${departmentsSkipped}`);
    console.log(`   • Municipalities created: ${municipalitiesCreated}`);
    console.log(`   • Municipalities skipped: ${municipalitiesSkipped}`);
  } catch (error) {
    console.error('❌ Error during seeding:', error);
  } finally {
    await AppDataSource.destroy();
  }
}

seedDepartmentsAndMunicipalities();
