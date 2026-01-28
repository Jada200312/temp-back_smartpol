import { NestFactory } from '@nestjs/core';
import { ValidationPipe } from '@nestjs/common';
import { SwaggerModule, DocumentBuilder } from '@nestjs/swagger';
import { AppModule } from './app.module';

async function bootstrap() {
  const app = await NestFactory.create(AppModule);

  // Global validation pipe
  app.useGlobalPipes(new ValidationPipe({
    whitelist: true,
    forbidNonWhitelisted: true,
    transform: true,
  }));

  // Swagger configuration
  const config = new DocumentBuilder()
    .setTitle('SmartPol API')
    .setDescription('RESTful API for managing political campaigns, candidates, leaders and voters')
    .setVersion('1.0.0')
    .addBearerAuth(
      { type: 'http', scheme: 'bearer', bearerFormat: 'JWT' },
      'access-token'
    )
    .addTag('System', '🏥 API status and health')
    .addTag('Authentication', '🔐 Authentication, registration and JWT session management')
    .addTag('Corporations', '🏢 Management of corporations and political groups')
    .addTag('Users', '👥 System user management')
    .addTag('Leaders', '👨‍💼 Management of political leaders and referents')
    .addTag('Candidates', '🗳️ Management of candidates and electoral campaigns')
    .addTag('Voters', '📊 Management of voters and electoral registry')
    .build();

  const document = SwaggerModule.createDocument(app, config);
  SwaggerModule.setup('api/docs', app, document);

  const port = process.env.PORT ?? 3000;
  await app.listen(port);
  console.log(`✓ Application running on: http://localhost:${port}`);
  console.log(`✓ Swagger documentation: http://localhost:${port}/api/docs`);
}
bootstrap();


