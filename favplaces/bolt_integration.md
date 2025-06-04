# FavPlaces - Bolt.new Integration Guide

## Prerequisites
1. Supabase project set up with the schema from `supabase_schema.sql`
2. Environment variables configured in `.env`

## Steps for Bolt.new Integration

### 1. Upload Project to Bolt.new
- Compress the entire `favplaces` directory
- Upload to bolt.new
- Install dependencies: `pip install -r requirements.txt`

### 2. Environment Configuration
Set these environment variables in bolt.new:
```
DJANGO_SECRET_KEY=your-secret-key
DEBUG=False
ALLOWED_HOSTS=your-bolt-domain.bolt.new
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_ANON_KEY=your-anon-key
SUPABASE_DB_HOST=db.your-project.supabase.co
SUPABASE_DB_NAME=postgres
SUPABASE_DB_USER=postgres
SUPABASE_DB_PASSWORD=your-password
```

### 3. Database Migration
Run these commands in bolt.new terminal:
```bash
python manage.py makemigrations
python manage.py migrate
python manage.py collectstatic --noinput
```

### 4. Supabase Setup
1. Create new Supabase project
2. Go to SQL Editor
3. Run the `supabase_schema.sql` script
4. Configure Row Level Security (RLS) if needed
5. Get connection details from Settings > Database

### 5. Frontend Integration (Optional)
If you want to add a React frontend:
```bash
npx create-react-app frontend
cd frontend
npm install @supabase/supabase-js axios
```

## Production Considerations
- Use strong passwords and secure keys
- Enable RLS on Supabase tables
- Configure CORS properly
- Use HTTPS in production
- Monitor database performance
